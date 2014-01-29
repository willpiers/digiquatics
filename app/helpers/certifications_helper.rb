module CertificationsHelper
  def render_certification_name_id_in_dev(cert)
    Rails.env.development? ? "(#{cert.certification_name_id.to_s})" : ''
  end

  def users_certification_expiration_data
    User.same_account_as(current_user).active.map do |user|
      user_data(user).merge certification_data(user)
    end
  end

  def certification_data(user)
    user.certifications.each_with_object({}) do |cert, hash|
      cert_name = cert.certification_name.name
      cert_date = cert.expiration_date

      hash[cert_name]           = cert_date
      hash["#{cert_name}class"] = css_class(cert_date)
    end
  end

  def user_data(user)
    {
      id: user.id,
      lastName: user.last_name,
      firstName: user.first_name,
      location: user.location.name,

      # Added for users index page, need to move elsewhere
      employee_id: user.employee_id,
      date_of_birth: user.date_of_birth,
      position: user.position.name,
      email: user.email,
      phone_number: user.phone_number,
      admin: user.admin,
      active: user.active
      # End
    }
  end

  def css_class(date)
    if date <= Date.today
      'danger'
    elsif date > Date.today && date <= (Date.today + 90.days)
      'warning'
    elsif date > (Date.today + 90.days)
      'success'
    end
  end
end
