
# make sure the RAILS_ENV variable is set so the
# resque-scheduler can load our scheduled jobs
ENV['RAILS_ENV'] = Rails.env
