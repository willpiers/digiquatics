require 'csv'

module Importer
  USER_HEADERS = %w(
    first_name last_name email phone_number secondary_phone_number
    employee_id notes address1 address2 city state zipcode emergency_first
    emergency_last emergency_phone sex shirt_size suit_size femalesuit payrate
    grouping active admin chemical_records_access private_lesson_access
)

  CERT_HEADERS = %w(
    expiration_date issue_date
)

  def self.import(user_data_file: '', cert_data_file: '')
    import_user_data(user_data_file)
    import_cert_data(cert_data_file)
  end

  def self.import_user_data(user_data_file)
    puts 'starting users' unless Rails.env.test?

    CSV.foreach(user_data_file, headers: true) do |user_row|
      @user_row = user_row
      puts @user_row unless Rails.env.test?
      @account ||= create_account
      @account.users.build(user_hash).save!
    end

    puts 'done with users' unless Rails.env.test?
  end

  def self.import_cert_data(cert_data_file)
    puts 'starting certs' unless Rails.env.test?

    CSV.foreach(cert_data_file, headers: true) do |cert_row|
      @cert_row = cert_row
      find_user_and_create_certification
    end

    puts 'finished certs' unless Rails.env.test?
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
      active:                 to_boolean(@user_row['active']),
      admin:                  to_boolean(@user_row['admin']),
      chemical_records_access: to_boolean(@user_row['chemical_records_access']),
      private_lesson_access:  to_boolean(@user_row['private_lesson_access'])
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

  def self.find_user_and_create_certification
    @user = User.find_by(email: @cert_row['email'].downcase)
    if @user
      @user.certifications.build(cert_hash).save!
    else
      puts "could not find #{@cert_row['email']} in database"
    end
  end

  def self.password
    'carbonvalley'
  end

  def self.parse_date(date_string)
    Date.strptime(date_string, '%m/%d/%Y') if date_string
  end

  def self.to_boolean(boolean_string)
    boolean_string == 'TRUE'
  end
end
