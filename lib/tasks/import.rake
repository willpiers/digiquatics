require 'csv'
require 'yaml'

namespace :db do
  desc 'Import customer data to database'
  task import: :environment do
    DATA_FILE = Rails.root.join('db/data/foothills/Foothills_user_data.csv')
    HEADERS = YAML.load_file(Rails.root.join('db/data/foothills/headers.yml'))
      .values
    CERT_NAMES = ['Red Cross Lifeguarding', 'AFO', 'LGTI']
    PASSWORD = 'foothillspools'
    ADMIN_EMAIL = 'digiquatics.admin@foothills.pools'

    puts "Importing data from #{DATA_FILE}"

    account = Account
    .find_or_create_by!(name: 'Foothills Parks & Recreation',
                        time_zone: 'Mountain Time (US & Canada)')

    CERT_NAMES.each do |cert_name|
      CertificationName.find_or_create_by(name: cert_name,
                                          account_id: account.id)
    end

    CSV.foreach(DATA_FILE, headers: HEADERS) do |user_row|
      next if ['Name', 'Revised', 'First'].include?(user_row['first_name'])

      date_of_birth =
      if user_row['date_of_birth_year'] &&
         user_row['date_of_birth_month'] &&
         user_row['date_of_birth_day']
        Date.new("19#{user_row['date_of_birth_year']}".to_i,
                 user_row['date_of_birth_month'].to_i,
                 user_row['date_of_birth_day'].to_i)
      end

      email =
      if user_row['email'].blank? #|| User.find_by_email(user_row['email'])
        "#{user_row['first_name']}.#{user_row['last_name']}@no.email"
        .delete(' \'')
      else
        user_row['email']
      end

      notes_headers = HEADERS.select { |header| header =~ /^notes_/ }

      notes = notes_headers.each_with_object('') do |notes_header, notes_string|
        info = notes_header.gsub('_', ' ')
        info.slice! 'notes '

        # this is not including the newlines...
        notes_string << "#{info}: #{user_row[notes_header]}\n"
      end

      user = User.find_or_initialize_by(email: email)
      .update_attributes!(last_name:             user_row['last_name'],
                          first_name:            user_row['first_name'],
                          phone_number:          user_row['phone_number'],
                          employee_id:           user_row['employee_id'],
                          payrate:               user_row['payrate'],
                          date_of_birth:         date_of_birth,
                          email:                 email,
                          notes:                 notes,
                          password:              PASSWORD,
                          password_confirmation: PASSWORD,
                          account_id:            account.id)

      print '.'
    end

    User.find_or_initialize_by(email: ADMIN_EMAIL)
    .update_attributes!(last_name:             'Admin',
                        first_name:            'DiqiQuatics',
                        password:              '@ffektive!',
                        password_confirmation: '@ffektive!',
                        active:                false,
                        admin:                 true,
                        account_id:            account.id)

    print '.'

    puts '', 'Importing complete!'
  end
end

# namespace :db do
#   desc 'Import customer data to database'
#   task import: :environment do
#     DATE_FILE_NAME = 'db/data/City_&_County_of_Denver_user_data.csv'
#     DATA_FILE = Rails.root.join(DATE_FILE_NAME)

#     puts "Importing data from #{DATA_FILE}"

#     account = Account
#     .find_or_create_by_name!('City & County of Denver',
#                              time_zone: 'Mountain Time (US & Canada)')

#     cpr_name = CertificationName.create!(name: 'CPR', account_id: account.id)
#     lgt_name = CertificationName.create!(name: 'LGT', account_id: account.id)

#     CSV.foreach(DATA_FILE, headers: true) do |user_row|
#       position = Position.find_or_create_by(name: user_row['position'],
#                                             account_id: account.id)

#       location = Location.find_or_create_by(name: user_row['location'],
#                                             account_id: account.id)

#       email =
#       if user_row['email'].blank? || User.find_by_email(user_row['email'])
#         "#{user_row['first_name']}.#{user_row['last_name']}@no.email"
#       else
#         user_row['email']
#       end

#       user = account.users.build(last_name:           user_row['last_name'],
#                                  first_name:          user_row['first_name'],
#                                  nickname:            user_row['nickname'],
#                                  phone_number:      user_row['phone_number'],
#                                  email:               email,
#                                  notes:               user_row['notes'],
#                                  password:            'denverpools',
#                                  password_confirmation: 'denverpools')
#       user.save!

#       user.update_attribute(:position_id, position.id) if position.valid?
#       user.update_attribute(:location_id, location.id) if location.valid?

#       unless user_row['CPR'].blank?
#         expiration_date = DateTime.strptime(user_row['CPR'], '%m/%d/%Y')

#         user.certifications.build(certification_name_id: cpr_name.id,
#                                   expiration_date:     expiration_date)
#         .save!
#       end

#       unless user_row['LGT'].blank?
#         expiration_date = DateTime.strptime(user_row['LGT'], '%m/%d/%Y')

#         user.certifications.build(certification_name_id: lgt_name.id,
#                                   expiration_date:       expiration_date)
#         .save!
#       end

#       print '.'
#     end

#     account.users.build(last_name:             'Admin',
#                         first_name:            'DiqiQuatics',
#                         email:                 'admin@digiquatics.com',
#                         password:              '@ffektive!',
#                         password_confirmation: '@ffektive!',
#                         active:                false,
#                         admin:                 true)
#     .save!

#     print '.'

#     puts '', 'Importing complete!'
#   end
# end
