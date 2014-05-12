class SlideMailer < ActionMailer::Base
  default from: 'Team@digiquatics.com'

  def urgent_slide_inspection(error, slide_inspection, account_id, user_id)
    @recipients = User.where(admin: true, account_id: account_id)
    emails = @recipients.map(&:email).join(',')
    @slide_inspection = slide_inspection
    @user = User.find_by_id(user_id)
    @error = error
    mail(to:  emails, from: 'team@digiquatics.com',
         subject: "#{slide_inspection.slide.name} Slide Inspection Issue at #{Location.find(@slide_inspection.slide.location.id).name}")
  end
end
