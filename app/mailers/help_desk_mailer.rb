class HelpDeskMailer < ActionMailer::Base
  default from: 'Team@digiquatics.com'

  def urgent_email(issue, account_id, location_id, current_user_location_id)
    @help_desk = issue
    mail(to: email(account_id, location_id, current_user_location_id), from: 'Team@digiquatics.com',
         subject: "Urgent Help Desk Issue at #{Location.find(@help_desk.location_id).name}")
  end

  def email(account_id, location_id, current_user_location_id)
    if Account.find_by_id(account_id).maintenance_group_email == true
      @group_recipients = EmailGroup.all
      group = @group_recipients.map(&:email).join(',')
    end

    if Account.find_by_id(account_id).maintenance_admin_email == true
      @admin_recipients = User.where(admin: true, account_id: account_id)
                        .where.not(email: nil)
      admin = @admin_recipients.map(&:email).join(',')
    end

    if Account.find_by_id(account_id).maintenance_location_email == true && location_id == current_user_location_id
      @location_recipients = User.where(admin: true, account_id: account_id, location_id: location_id)
                        .where.not(email: nil)
      location = @location_recipients.map(&:email).join(',')
    end

    @array = [group, admin, location].compact
    @array.join(',')

  end
end
