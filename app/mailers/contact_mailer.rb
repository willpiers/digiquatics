class ContactMailer < ActionMailer::Base
  default from: 'Team@digiquatics.com'

  def contact_email(location_id, position_id, admin, account_id, subject, message)
    @subject = subject
    @message = message
    mail(to: email(location_id, position_id, admin, account_id),
         from: 'Team@digiquatics.com',
         subject: @subject)
  end

  def email(location_id, position_id, admin, account_id)
    if location_id && position_id then
      @email_1 = User.where(account_id: account_id,
                            location_id: location_id,
                            position_id: position_id)
                                  .where.not(email: nil)
      email_1 = @email_1.map(&:email).join(',')
    elsif location_id
      @email_2 = User.where(account_id: account_id,
                            location_id: location_id,
                            position_id: 0)
                                  .where.not(email: nil)
      email_2 = @email_2.map(&:email).join(',')

    elsif position_id
      @email_3 = User.where(account_id: account_id,
                            location_id: nil,
                            position_id: position_id)
                                  .where.not(email: nil)
      email_3 = @email_3.map(&:email).join(',')
    end

    @array = [email_1, email_2, email_3].compact
    @array.join(',')
  end
end
