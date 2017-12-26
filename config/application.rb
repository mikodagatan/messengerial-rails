require_relative 'boot'

require 'rails/all'
require 'pdfkit'
require 'resque'
require "active_job/railtie"

Bundler.require(*Rails.groups)

module Messengerial3
  class Application < Rails::Application
    config.load_defaults 5.1
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.enabled = true
    config.middleware.use PDFKit::Middleware, :print_media_type => true
    config.wkhtmltopdf = `which wkhtmltopdf`.gsub(/\n/, '')
    config.active_job.queue_adapter = :resque
    config.active_record.default_timezone = :local
    config.time_zone = 'Singapore'
  end
end
