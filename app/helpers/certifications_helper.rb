module CertificationsHelper
  def render_certification_name_id_in_dev(cert)
    Rails.env.development? ? "(#{cert.certification_name_id.to_s})" : ''
  end
end
