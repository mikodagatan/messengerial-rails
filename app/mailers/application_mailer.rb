class ApplicationMailer < ActionMailer::Base
  default from: 'Hello@example.com'
  helper ApplicationHelper
  layout 'mailer'
end
