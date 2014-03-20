namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    Rake.application['db:reset'].invoke

    Account.create(name: 'City of Lakewood',
                   time_zone: 'Mountain Time (US & Canada)')
    Account.create(name: 'Foothills',
                   time_zone: 'Mountain Time (US & Canada)')
    Account.create(name: 'Empty',
                   time_zone: 'Mountain Time (US & Canada)')

    Location.create(name: 'Green Mountain Recreation Center',
                    account_id: 1)
    Location.create(name: 'The Link Recreation Center',
                    account_id: 1)
    Location.create(name: 'Ridge Recreation Center',
                    account_id: 2)

    Pool.create(name: 'Big',  location_id: Location.first.id)
    Pool.create(name: 'Baby', location_id: Location.first.id)
    Pool.create(name: 'Link', location_id: Location.find(2).id)

    Position.create(name: 'Lifeguard',
                    account_id: 1)
    Position.create(name: 'MOD',
                    account_id: 1)
    Position.create(name: 'WSI',
                    account_id: 1)

    User.create!(first_name:            'First',
                 nickname:              'Dubs',
                 last_name:             'Last',
                 phone_number:          '303-123-4567',
                 email:                 'example@affektive.com',
                 password:              'foobar22',
                 password_confirmation: 'foobar22',
                 date_of_birth:         '1992-09-15',
                 sex:                   'F',
                 address1:              '14277 E Warren Dr.',
                 address2:              'Unit B',
                 city:                  'Lakewood',
                 state:                 'CO',
                 zipcode:               '80228',
                 shirt_size:            'M',
                 suit_size:             'M',
                 femalesuit:            '30',
                 emergency_first:       'Lydia',
                 emergency_last:        'Campbell',
                 emergency_phone:       '303-222-1313',
                 location_id:           1,
                 position_id:           2,
                 employee_id:           1313,
                 grouping:              'West',
                 date_of_hire:          '2008-07-01',
                 payrate:               '9.50',
                 admin:                 true,
                 active:                true,
                 account_id:            1)

    100.times do |n|

      User.create!(first_name: Faker::Name.first_name,
                   nickname: Faker::Name.name,
                   last_name: Faker::Name.last_name,
                   phone_number: Faker::PhoneNumber.phone_number,
                   email: Faker::Internet.email,
                   password: 'password',
                   password_confirmation: 'password',
                   date_of_birth: '1992-09-15',
                   sex: %w(M F).sample,
                   address1: Faker::Address.street_address,
                   address2: Faker::Address.secondary_address,
                   city: Faker::Address.city,
                   state: Faker::Address.state_abbr,
                   zipcode: Faker::Address.zip_code,
                   shirt_size: %w(XS S M L XL).sample,
                   suit_size: %w(XS S M L XL).sample,
                   femalesuit: [28, 30, 32, 34, 36, 38, 40].sample,
                   location_id: rand(2) + 1,
                   emergency_first: Faker::Name.first_name,
                   emergency_last: Faker::Name.last_name,
                   emergency_phone: Faker::PhoneNumber.phone_number,
                   position_id: rand(3) + 1,
                   employee_id: rand(1000),
                   grouping: %w(North West East South).sample,
                   date_of_hire: '2008-07-01',
                   payrate: [8.00, 8.50, 9.00, 9.50, 10.00, 10.50].sample,
                   admin: false,
                   active: [true, false].sample,
                   account_id: 1
                   )
    end

    CertificationName.create!(name: 'CPR_AED',
                              account_id: 1)
    CertificationName.create!(name: 'LGI',
                              account_id: 1)
    CertificationName.create!(name: 'WSI',
                              account_id: 1)

    99.times do |n|
      Certification.create!(certification_name_id: 1,
                            user_id: n + 1,
                            expiration_date: Date.today + rand(365).day,
                            issue_date: Date.today + rand(365).day)

      Certification.create!(certification_name_id: 2,
                            user_id: n + 1,
                            expiration_date: Date.today + rand(365).day,
                            issue_date: Date.today + rand(365).day)

      Certification.create!(certification_name_id: 3,
                            user_id: n + 1,
                            expiration_date: Date.today + rand(365).day,
                            issue_date: Date.today + rand(365).day)
    end

    50.times do |n|
      PrivateLesson.create!(first_name: Faker::Name.first_name,
                            last_name: Faker::Name.last_name,
                            parent_first_name: Faker::Name.first_name,
                            parent_last_name: Faker::Name.last_name,
                            email: Faker::Internet.email,
                            phone_number: Faker::PhoneNumber.phone_number,
                            age: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].sample,
                            sex: %w(M F).sample,
                            instructor_gender: %w(M F None).sample,
                            day: %w(M T W Th F S Sn).sample,
                            time: %w(AM PM).sample,
                            contact_method: %w(Call Email Text).sample,
                            notes: 'Nothing to say now',
                            preferred_location: rand(3) + 1,
                            number_lessons: rand(5) + 1,
                            account_id: 1)
    end

    250.times do |n|
      si_status = ['Severe Corrosion', 'Moderate Corrosion', 'Mild Corrosion',
                   'Balanced', 'Some Faint Coating', 'Mild Scale Coating',
                   'Mild to Moderate Coatings', 'Moderate Scale Forming',
                   'Severe Scale Forming']
      si_recommendation = ['Treatment Recommended', 'Treatment May Be Needed',
                           'Probably No Treatment', 'No Treatment',
                           'Treatment May Be Needed', 'Treatment Recommended']
      water_clarity = %w(Clear Cloudy)
      free_cl_ppm = rand(2) + 1
      combined_cl_ppm = rand(2) + 1

      ChemicalRecord.create!(free_chlorine_ppm: free_cl_ppm,
                             combined_chlorine_ppm: combined_cl_ppm,
                             total_chlorine_ppm: free_cl_ppm + combined_cl_ppm,
                             ph: [6.8, 6.9, 7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6,
                                  7.7, 7.8, 7.9, 8.0].sample,
                             alkalinity: [30, 40, 50, 60, 70, 80, 90, 100, 110,
                                          120, 130].sample,
                             calcium_hardness: [60, 80, 100, 120, 140, 160,
                                                180, 200].sample,
                             pool_temp: [81, 82, 83, 84, 85, 86].sample,
                             air_temp: [75, 76, 77, 78, 79, 80].sample,
                             water_clarity: water_clarity.sample,
                             time_stamp: '10:00pm',
                             si_index: [-1, -0.5, -0.3, 0, 0.3, 0.5, 1].sample,
                             si_status: si_status.sample,
                             si_recommendation: si_recommendation.sample,
                             pool_id: Pool.take(3).map(&:id).sample,
                             user_id: [1, 2, 3, 4, 5].sample)
    end

    25.times do |n|
      HelpDesk.create!(name: %w(A B C D).sample,
                       urgency: %w(Low Medium High).sample,
                       issue_status: true,
                       location_id: 1,
                       user_id: n + 1,
                       closed_user_id: n + 2
                       )
    end

    100.times do |n|
      ShiftReport.create!(date_stamp: Date.today - rand(365).day,
                          time_stamp: '10:00pm',
                          user_id: n + 1,
                          location_id: [1, 2].sample,
                          report_filed: [true, false].sample,
                          post_content: 'Blah blah blah'
                        )
    end
  end
end
