class SlideMailer < ActionMailer::Base
  default from: 'Josh@digiquatics.com'

  def urgent_slide_inspection(error, slide_inspection, account_id, location_id, current_user_location_id, user_id)
    @slide_inspection = slide_inspection
    @user = User.find_by_id(user_id)
    @error = error
    mail(to: email(account_id, location_id, current_user_location_id),
         from: 'Josh@digiquatics.com',
         subject: "#{slide_inspection.slide.name} Slide Inspection Issue at #{Location.find(@slide_inspection.slide.location.id).name}")
  end

  def email(account_id, location_id, current_user_location_id)
    if Account.find_by_id(account_id).slides_group_email == true
      @group_recipients = EmailGroup.all
      group = @group_recipients.map(&:email).join(',')
    end

    if Account.find_by_id(account_id).slides_admin_email == true
      @admin_recipients = User.where(admin: true, account_id: account_id)
                        .where.not(email: nil)
      admin = @admin_recipients.map(&:email).join(',')
    end

    if Account.find_by_id(account_id).slides_location_email == true &&  location_id == current_user_location_id
      @location_recipients = User.where(admin: true, account_id: account_id, location_id: location_id)
                        .where.not(email: nil)
      location = @location_recipients.map(&:email).join(',')
    end

    @array = [group, admin, location].compact
    @array.join(',')
  end
end
