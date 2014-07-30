module CertificationsHelper
  def css_class(date)
    case date
    when (Date.today - 3000.days)..(Date.today)
      'danger'
    when (Date.today)...(Date.today + 90.days)
      'warning'
    when (Date.today + 90.days)..(Date.today + 180.days)
      'cert_blue'
    else
      'success'
    end
  end
end
