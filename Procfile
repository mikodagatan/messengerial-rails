worker:  RAILS_ENV=production bundle exec rake resque:work QUEUE='*'
scheduler: RAILS_ENV=production bundle exec rake resque:scheduler
faye: bundle exec rackup private_pub.ru -s thin -E production
