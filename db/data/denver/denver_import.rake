namespace :db do
  desc 'Import customer data to database'
  task import: :environment do
    DATE_FILE_NAME = 'db/data/City_&_County_of_Denver_user_data.csv'
    DATA_FILE = Rails.root.join(DATE_FILE_NAME)

    puts "Importing data from #{DATA_FILE}"

    account = Account
    .find_or_create_by_name!('City & County of Denver',
                             time_zone: 'Mountain Time (US & Canada)')

    cpr_name = CertificationName.create!(name: 'CPR', account_id: account.id)
    lgt_name = CertificationName.create!(name: 'LGT', account_id: account.id)

    CSV.foreach(DATA_FILE, headers: true) do |user_row|
      position = Position.find_or_create_by(name: user_row['position'],
                                            account_id: account.id)

      location = Location.find_or_create_by(name: user_row['location'],
                                            account_id: account.id)

      email =
      if user_row['email'].blank? || User.find_by_email(user_row['email'])
        "#{user_row['first_name']}.#{user_row['last_name']}@no.email"
      else
        user_row['email']
      end

      user = account.users.build(last_name:           user_row['last_name'],
                                 first_name:          user_row['first_name'],
                                 nickname:            user_row['nickname'],
                                 phone_number:      user_row['phone_number'],
                                 email:               email,
                                 notes:               user_row['notes'],
                                 password:            'denverpools',
                                 password_confirmation: 'denverpools')
      user.save!

      user.update_attribute(:position_id, position.id) if position.valid?
      user.update_attribute(:location_id, location.id) if location.valid?

      unless user_row['CPR'].blank?
        expiration_date = DateTime.strptime(user_row['CPR'], '%m/%d/%Y')

        user.certifications.build(certification_name_id: cpr_name.id,
                                  expiration_date:     expiration_date)
        .save!
      end

      unless user_row['LGT'].blank?
        expiration_date = DateTime.strptime(user_row['LGT'], '%m/%d/%Y')

        user.certifications.build(certification_name_id: lgt_name.id,
                                  expiration_date:       expiration_date)
        .save!
      end

      print '.'
    end

    account.users.build(last_name:             'Admin',
                        first_name:            'DiqiQuatics',
                        email:                 'admin@digiquatics.com',
                        password:              '@ffektive!',
                        password_confirmation: '@ffektive!',
                        active:                false,
                        admin:                 true)
    .save!

    print '.'

    puts '', 'Importing complete!'
  end
end
