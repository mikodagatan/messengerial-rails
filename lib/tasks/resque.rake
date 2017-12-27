require 'resque/tasks'
require 'resque/scheduler/tasks'
require 'resque/pool/tasks'

namespace :resque do
  task :setup => :environment do
    require 'resque'
    ENV['QUEUE'] = '*'
    Rake::Task["resque:work"].invoke
    Rake::Task["resque:scheduler"].invoke
    Resque.redis = 'localhost:6379' unless Rails.env == 'production'
  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'
    Resque.schedule = YAML.load_file('config/resque_schedule.yml')
  end

  task :scheduler => :setup_schedule
end


Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection } #this is necessary for production environments, otherwise your background jobs will start to fail when hit from many different connections.

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"

task "resque:pool:setup" do
  Resque::Pool.after_prefork do |job|
    Resque.redis.client.reconnect
  end
end
