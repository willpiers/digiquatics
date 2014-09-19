class ChemicalRecordMailer < ActionMailer::Base
  default from: 'Josh@digiquatics.com'

  def urgent_email(record, account_id, location_id, current_user_location_id)
    @chemical_record = record
    mail(to: email(account_id, location_id, current_user_location_id),
         from: 'Josh@digiquatics.com',
         subject: "Urgent Chemical Record Issue at #{Location.find(@chemical_record.location_id).name}")
  end

  def email(account_id, location_id, current_user_location_id)
    if Account.find_by_id(account_id).chemical_records_group_email == true
      @group_recipients = EmailGroup.all
      group = @group_recipients.map(&:email).join(',')
    end

    if Account.find_by_id(account_id).chemical_records_admin_email == true
      @admin_recipients = User.where(admin: true, account_id: account_id)
                        .where.not(email: nil)
      admin = @admin_recipients.map(&:email).join(',')
    end

    if Account.find_by_id(account_id).chemical_records_location_email == true && location_id == current_user_location_id
      @location_recipients = User.where(admin: true, account_id: account_id, location_id: location_id)
                        .where.not(email: nil)
      location = @location_recipients.map(&:email).join(',')
    end

    @array = [group, admin, location].compact
    @array.join(',')
  end
end
