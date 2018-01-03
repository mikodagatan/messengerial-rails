# config valid only for current version of Capistrano
lock "3.10.1"

set :application, "offshore-tracker"
set :repo_url, "git@bitbucket.org:kimonoso/messengerial3.git"

# Default branch is :master
# ask :branch, 'master'/

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/offshore-tracker"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :use_sudo, true

# append :linked_files, "config/database.yml", "config/secrets.yml"
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

namespace :rails do
  desc 'Open a rails console `cap [staging] rails:console [server_index default: 0]`'
  task :console do
    server = roles(:app)[ARGV[2].to_i]

    puts "Opening a console on: #{server.hostname}...."

    cmd = "ssh #{server.user}@#{server.hostname} -t 'cd #{fetch(:deploy_to)}/current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"

    puts cmd

    exec cmd
  end

  set :rbenv_ruby, '2.4.0'
  set :rbenv_ruby_version, '2.4.0'

  role :resque_worker, "128.199.157.80"
  role :resque_scheduler, "128.199.157.80"

  set :workers, { "tasks_email" => 2 }
  set :resque_environment_task, true
  after "deploy:restart", "resque:restart"

  task :export do

    on roles(:app) do
      execute [
        "cd #{release_path} &&",
        'export rvmsudo_secure_path=0 && ',
        "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do",
        'rvmsudo',
        'RAILS_ENV=production bundle exec foreman export --app appname --user username -l logfile-path -f ./Procfile upstart /etc/init -c worker=1,scheduler=1,faye=1'
      ].join(' ')
    end
  end


  task :restart do
    on roles(:app) do
      execute :sudo, "restart appname"
    end
  end
  # after :publishing, :export
  # after :publishing, :restart
end
