class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  default to: 'to@example.com'
  layout 'mailer'
end

