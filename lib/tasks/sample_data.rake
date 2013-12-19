namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    Account.create!(name: "City of Lakewood")
    Account.create!(name: "Foothills")

    User.create!(first_name: "first",
                 last_name: "last",
                 email: "example@affektive.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 phone_number: 1234,
                 shirt_size: "M",
                 suit_size: "M",
                 date_of_birth: "1992-09-15",
                 date_of_hire: "2008-07-01",
                 admin: true,
                 account_id: 1)

    100.times do |n|
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
                   shirt_size: "M",
                   date_of_birth: "1992-09-15",
                   date_of_hire: "2008-07-01",
                   account_id: 1)
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

    Locations.create! (name: "Green Mountain Recreation Center", account_id: 1)
    Locations.create! (name: "The Link Recreation Center", account_id: 2)
    Locations.create! (name: "Whitlock Recreation Center", account_id: 3)

    99.times do |n|
      Locations.create!(:location_id: 1,
                   user_id: n+1,
                   "test1")
    end

    100.times do |n|
      Locations.create!(:location_id: 2,
                   user_id: n+2,
                   "test2")
    end

    101.times do |n|
      Locations.create!(:location_id: 3,
                   user_id: n+3,
                   "test3")
    end

  end
end
