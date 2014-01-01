namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    Account.create(name: "City of Lakewood", time_zone: 'Mountain Time (US & Canada)')
    Account.create(name: "Foothills", time_zone: 'Mountain Time (US & Canada)')

    Location.create(name: "Green Mountain Recreation Center", account_id: 1)
    Location.create(name: "The Link Recreation Center", account_id: 1)
    Location.create(name: "Ridge Recreation Center", account_id: 2)

    Position.create(name: "Lifeguard", account_id: 1)
    Position.create(name: "MOD", account_id: 1)
    Position.create(name: "WSI", account_id: 1)

    User.create!(first_name: "First",
                 last_name: "Last",
                 email: "example@affektive.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 phone_number: '303-123-4567',
                 shirt_size: "M",
                 suit_size: "M",
                 sex: "F",
                 date_of_birth: "1992-09-15",
                 date_of_hire: "2008-07-01",
                 admin: true,
                 active: true,
                 account_id: 1,
                 location_id: 1,
                 position_id: 2)

    100.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      phone_number = Faker::PhoneNumber.phone_number
      email = Faker::Internet.email
      sex = ["M","F"]
      suit_size = ["XS", "S", "M", "L", "XL"]
      shirt_size = ["XS", "S", "M", "L", "XL"]
      password  = "password"
      sex = ["M","F"]

      User.create!(first_name: first_name, last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   phone_number: phone_number,
                   suit_size: suit_size.sample,
                   shirt_size: shirt_size.sample,
                   sex: sex.sample,
                   date_of_birth: "1992-09-15",
                   date_of_hire: "2008-07-01",
                   active: true,
                   account_id: 1,
                   location_id: [1,2,3].sample,
                   position_id: [1,2,3].sample
                   )
    end

    CertificationName.create!(name: "CPR/AED", account_id: 1)
    CertificationName.create!(name: "LGI", account_id: 1)
    CertificationName.create!(name: "WSI", account_id: 1)

    99.times do |n|
      Certification.create!(certification_name_id: 1,
        user_id: n+1,
        expiration_date: Date.today + rand(100).day,
        issue_date: Date.today + rand(100).day )

      Certification.create!(certification_name_id: 2,
        user_id: n+1,
        expiration_date: Date.today + rand(100).day,
        issue_date: Date.today + rand(100).day )

      Certification.create!(certification_name_id: 3,
        user_id: n+1,
        expiration_date: Date.today + rand(100).day,
        issue_date: Date.today + rand(100).day )
    end

    20.times do |n|
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
                            instructor_gender: ["M", "F"].sample,
                            ability_level: skill.sample,
                            day: day.sample,
                            time: time.sample,
                            notes: "Nothing to say now",
                            preferred_location: [1,2,3].sample,
                            user_id: [1,2,3].sample)
    end


    50.times do |n|

      ChemicalRecord.create!(chlorine_ppm: [1,2,3,4,5].sample,
                           ph: [7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 8.0].sample,
                           alkalinity: [50,60,70,80,90,100].sample,
                           calcium_hardness: [60, 80, 100, 120, 140].sample,
                           pool_temp: [81, 82, 83, 84, 85, 86].sample,
                           air_temp: [75, 76, 77, 78, 79, 80].sample,
                           si_index: [-0.3, -0.2, -0.1, 0.0, 0.1, 0.2, 0.3].sample
      )
    end
  end
end
