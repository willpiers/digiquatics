class HelpDeskMailer < ActionMailer::Base
  default from: 'Team@digiquatics.com'

  def urgent_email(issue, account_id)
    @recipients = User.where(admin: true, account_id: account_id)
                      .where.not(email: nil, location_id: nil)
    emails = @recipients.map(&:email).join(',')
    @help_desk = issue
    mail(to: emails, from: 'Team@digiquatics.com',
         subject: "Urgent Help Desk Issue at #{Location.find(@help_desk.location_id).name}")
  end
end
