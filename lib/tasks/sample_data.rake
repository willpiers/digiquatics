namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    Account.create(name: "City of Lakewood")
    Account.create(name: "Foothills")

    Location.create(name: "Green Mountain Recreation Center", account_id: 1)
    Location.create(name: "The Link Recreation Center", account_id: 1)
    Location.create(name: "Whitlock Recreation Center", account_id: 2)

    Position.create(name: "Lifeguard", account_id: 1)
    Position.create(name: "MOD", account_id: 1)

    User.create!(first_name: "first",
                 last_name: "last",
                 email: "example@affektive.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 phone_number: 1234,
                 shirt_size: "M",
                 suit_size: "M",
                 sex: "M",
                 date_of_birth: "1992-09-15",
                 date_of_hire: "2008-07-01",
                 admin: true,
                 account_id: 1,
                 location_id: 1,
                 position_id: 2)

    50.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "example-#{n+1}@affektive.com"
      password  = "password"
      User.create!(first_name: first_name, last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   phone_number: "123#{n+1}",
                   suit_size: "M",
                   shirt_size: "L",
                   sex: "M",
                   date_of_birth: "1992-09-15",
                   date_of_hire: "2008-07-01",
                   account_id: 1,
                   location_id: 1,
                   position_id: 1)
    end

    50.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "example-#{n+51}@affektive.com"
      password  = "password"
      User.create!(first_name: first_name, last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   phone_number: "123#{n+1}",
                   suit_size: "S",
                   shirt_size: "S",
                   sex: "F",
                   date_of_birth: "1992-09-15",
                   date_of_hire: "2008-07-01",
                   account_id: 1,
                   location_id: 2,
                   position_id: 2)
    end

    CertificationName.create!(name: "CPR/AED", account_id: 1)
    CertificationName.create!(name: "LGI", account_id: 1)
    CertificationName.create!(name: "WSI", account_id: 1)
    CertificationName.create!(name: "LGI2", account_id: 2)

    99.times do |n|
      Certification.create!(certification_name_id: 1,
                   user_id: n+1,
                   expiration_date: Date.today + n.day)
    end

    100.times do |n|
      Certification.create!(certification_name_id: 2,
                   user_id: n+2,
                   expiration_date: Date.today + n.day)
    end

    101.times do |n|
      Certification.create!(certification_name_id: 3,
                   user_id: n+3,
                   expiration_date: Date.today + n.day)
    end
  end
end
