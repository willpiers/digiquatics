module CertificationsHelper
  def css_class(date)
    case date.to_date
    when (Date.today - 3000.days)..(Date.today)
      'redCell'
    when (Date.today)...(Date.today + 90.days)
      'yellowCell'
    when (Date.today + 90.days)..(Date.today + 180.days)
      'blueCell'
    else
      'greenCell'
    end
  end
end
