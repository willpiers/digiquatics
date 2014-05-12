class PrivateLessonMailer < ActionMailer::Base
  default from: 'PrivateLessonRequests@DigiQuatics.com'

  def thank_you(private_lesson, account_id)
    @private_lesson = private_lesson
    mail(to: @private_lesson.email,
         from: 'PrivateLessonRequests@DigiQuatics.com',
         subject: "Thank you for your lesson request at #{Account.find(account_id).name}")
  end
end
