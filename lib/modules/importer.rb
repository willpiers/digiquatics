require 'csv'

module Importer
  USER_HEADERS = %w{
    first_name last_name email nickname phone_number secondary_phone_number
    employee_id notes address1 address2 city state zipcode emergency_first
    emergency_last emergency_phone sex shirt_size suit_size femalesuit payrate
    grouping
  }

  CERT_HEADERS = %w{
    expiration_date issue_date
  }

  def self.import(user_data_file: '', cert_data_file: '')
    import_user_data(user_data_file)
    import_cert_data(cert_data_file)
  end

  def self.import_user_data(user_data_file)
    puts 'starting users'
    sleep(1)
    CSV.foreach(user_data_file, headers: true) do |user_row|
      @user_row = user_row
      @account ||= create_account
      @account.users.build(user_hash).save!
    end
    puts 'done with users'
    sleep(1)
  end

  def self.import_cert_data(cert_data_file)
    puts 'starting certs'
    sleep(1)
    CSV.foreach(cert_data_file, headers: true) do |cert_row|
      @cert_row = cert_row
      @user ||= find_user
      @user.certifications.build(cert_hash).save!
    end
    puts 'finished certs'
    sleep(1)
  end

  def self.create_account
    Account.create_with(time_zone: @user_row['account_time_zone'])
    .find_or_create_by!(name: @user_row['account_name'])
  end

  def self.user_hash
    headers_user_hash.merge(specialty_user_hash).merge(associations_user_hash)
  end

  def self.cert_hash
    headers_cert_hash.merge(associations_cert_hash)
  end

  def self.specialty_user_hash
    {
      password:               password,
      password_confirmation:  password,
      date_of_birth:          parse_date(@user_row['date_of_birth']),
      date_of_hire:           parse_date(@user_row['date_of_hire']),
      active:                 to_boolean(@user_row['active'])
    }
  end

  def self.associations_user_hash
    {
      position_id: create_or_find_position.id,
      location_id: create_or_find_location.id
    }
  end

  def self.associations_cert_hash
    {
      certification_name_id: create_or_find_cert_name.id
    }
  end

  def self.headers_user_hash
    USER_HEADERS.each_with_object({}) do |header, hash|
      hash[header] = @user_row[header]
    end
  end

  def self.headers_cert_hash
    CERT_HEADERS.each_with_object({}) do |header, hash|
      hash[header] = @cert_row[header]
    end
  end

  def self.create_or_find_position
    Position.find_or_create_by(name: @user_row['position_name'],
                               account_id: @account.id)
  end

  def self.create_or_find_location
    Location.find_or_create_by(name: @user_row['location_name'],
                               account_id: @account.id)
  end

  def self.create_or_find_cert_name
    CertificationName.find_or_create_by(name: @cert_row['certification_name'],
                                        account_id: @account.id)
  end

  def self.find_user
    User.find_by(email: @cert_row['email'])
  end

  def self.password
    'foothills'
  end

  def self.parse_date(date_string)
    Date.strptime(date_string, '%m/%d/%Y') if date_string
  end

  def self.to_boolean(boolean_string)
    boolean_string == 'true'
  end
end
