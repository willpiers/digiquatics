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
    unless user.location
      user_location = ''
    else
      user_location = user.location.name
    end

    {
      id: user.id,
      lastName: user.last_name,
      firstName: user.first_name,
      location: user_location
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
