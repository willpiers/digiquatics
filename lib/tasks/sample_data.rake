namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake.application['db:reset'].invoke

    Account.create(name: "City of Lakewood",
                   time_zone: 'Mountain Time (US & Canada)')
    Account.create(name: "Foothills", time_zone: 'Mountain Time (US & Canada)')

    Location.create(name: "Green Mountain Recreation Center", account_id: 1)
    Location.create(name: "The Link Recreation Center", account_id: 1)
    Location.create(name: "Ridge Recreation Center", account_id: 2)

    Position.create(name: "Lifeguard", account_id: 1)
    Position.create(name: "MOD", account_id: 1)
    Position.create(name: "WSI", account_id: 1)

    User.create!(first_name:            "First",
                 nickname:              "Dubs",
                 last_name:             "Last",
                 phone_number:          '303-123-4567',
                 email:                 "example@affektive.com",
                 password:              "foobar22",
                 password_confirmation: "foobar22",
                 date_of_birth:         "1992-09-15",
                 sex:                   "F",
                 address1:              "14277 E Warren Dr.",
                 address2:              "Unit B",
                 city:                  'Lakewood',
                 state:                 'CO',
                 zipcode:               '80228',
                 shirt_size:            "M",
                 suit_size:             "M",
                 femalesuit:            '30',
                 emergency_first:       'Lydia',
                 emergency_last:        'Campbell',
                 emergency_phone:       '303-222-1313',
                 location_id:           1,
                 position_id:           2,
                 employee_id:           1313,
                 grouping:              'West',
                 date_of_hire:          "2008-07-01",
                 payrate:               '9.50',
                 admin:                 true,
                 active:                true,
                 account_id:            1)

    100.times do |n|
      first_name  = Faker::Name.first_name
      nickname  = Faker::Name.name
      last_name = Faker::Name.last_name
      phone_number = Faker::PhoneNumber.phone_number
      email = Faker::Internet.email
      password  = "password"
      sex = ["M","F"]
      address1 = Faker::Address.street_address(include_secondary = false)
      address2 = Faker::Address.secondary_address
      city = Faker::Address.city
      state_abbr = Faker::Address.state_abbr
      zip_code = Faker::Address.zip_code
      shirt_size = ["XS", "S", "M", "L", "XL"]
      suit_size = ["XS", "S", "M", "L", "XL"]
      emergency_first  = Faker::Name.first_name
      emergency_last = Faker::Name.last_name
      emergency_phone = Faker::PhoneNumber.phone_number
      grouping = ["North", "West", "East", "South"]
      payrate = [8.00, 8.50, 9.00, 9.50, 10.00, 10.50, 11.00]

      User.create!(first_name: first_name,
                   nickname: nickname,
                   last_name: last_name,
                   phone_number: phone_number,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   date_of_birth: "1992-09-15",
                   sex: sex.sample,
                   address1: address1,
                   address2: address2,
                   city: city,
                   state: state_abbr,
                   zipcode: zip_code,
                   shirt_size: shirt_size.sample,
                   suit_size: suit_size.sample,
                   femalesuit: [28, 30, 32, 34, 36, 38, 40].sample,
                   location_id: rand(2) + 1,
                   emergency_first: emergency_first,
                   emergency_last: emergency_last,
                   emergency_phone: emergency_phone,
                   position_id: rand(3) + 1,
                   employee_id: rand(1000),
                   grouping: grouping.sample,
                   date_of_hire: "2008-07-01",
                   payrate: payrate,
                   admin: false,
                   active: [true, false].sample,
                   account_id: 1
                   )
    end

    CertificationName.create!(name: "CPR_AED", account_id: 1)
    CertificationName.create!(name: "LGI", account_id: 1)
    CertificationName.create!(name: "WSI", account_id: 1)

    99.times do |n|
      Certification.create!(certification_name_id: 1,
        user_id: n+1,
        expiration_date: Date.today + rand(365).day,
        issue_date: Date.today + rand(365).day)

      Certification.create!(certification_name_id: 2,
        user_id: n+1,
        expiration_date: Date.today + rand(365).day,
        issue_date: Date.today + rand(365).day)

      Certification.create!(certification_name_id: 3,
        user_id: n+1,
        expiration_date: Date.today + rand(365).day,
        issue_date: Date.today + rand(365).day)
    end

    50.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      age = [1,2,3,4,5,6,7,8,9,10,11,12]
      sex = ["M", "F"]
      skill = [1,2,3,4,5,6]
      day = ["M", "T", "W","Th","F","S","Sn"]
      time =["AM", "PM"]

      PrivateLesson.create!(first_name: first_name, last_name: last_name,
                            parent_first_name: Faker::Name.first_name,
                            parent_last_name: Faker::Name.last_name,
                            email: Faker::Internet.email,
                            phone_number: Faker::PhoneNumber.phone_number,
                            age: age.sample,
                            sex: sex.sample,
                            instructor_gender: ["M", "F", "None"].sample,
                            day: day.sample,
                            time: time.sample,
                            contact_method: ["Call", "Email", "Text"].sample,
                            notes: "Nothing to say now",
                            preferred_location: rand(3) + 1,
                            number_lessons: rand(5) + 1 )
    end

    250.times do |n|
      ChemicalRecord.create!(chlorine_ppm: rand(5) + 1,
                           ph: [6.8, 6.9, 7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6,
                            7.7, 7.8, 7.9, 8.0].sample,
                           alkalinity: [30, 40, 50,60,70,80,90,100, 110, 120,
                            130].sample,
                           calcium_hardness: [60, 80, 100, 120, 140, 160, 180,
                            200].sample,
                           pool_temp: [81, 82, 83, 84, 85, 86].sample,
                           air_temp: [75, 76, 77, 78, 79, 80].sample,
                           date_stamp: "2014-01-01",
                           time_stamp: "10:00pm",
                           si_index: [-1, -0.5, -0.3, 0, 0.3, 0.5, 1].sample,
                           si_status: "SAMPLE NA",
                           si_recommendation: "SAMPLE NA"
      )
    end

    25.times do |n|
      HelpDesk.create!(name: ["A", "B", "C", "D"].sample,
                       urgency: ["Low", "Medium", "High"].sample,
                       issue_status: true,
                       location_id: 1,
                       user_id: n+1
                       )
    end
  end
end
