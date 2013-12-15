namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(first_name: "first",
                         last_name: "last",
                         email: "example@affektive.com",
                         password: "foobar",
                         password_confirmation: "foobar",
                         phone_number: "123921628",
                         shirt_size: "M", 
                         suit_size: "M",
                         date_of_birth: "1992-09-15",
                         date_of_hire: "2008-07-01",
                         admin: true,
                         account_id: "1")
    100.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "example-#{n+1}@affektive.com"
      password  = "password"
      User.create!(first_name: first_name, last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   phone_number: "12392162#{n+1}",
                   suit_size: "M",
                   shirt_size: "M",
                   date_of_birth: "1992-09-15",
                   date_of_hire: "2008-07-01",
                   account_id: "1")
    end

    Account.create!(name: "City of Lakewood")
    Account.create!(name: "Foothills")

    CertificationName.create!(name: "CPR/AED1", account_id: "1")
    CertificationName.create!(name: "LGI1", account_id: "1")
    CertificationName.create!(name: "LGI2", account_id: "2")

    Certification.create!(certification_name_id: "1", user_id: "1", expiration_date: "2012-09-05")
    Certification.create!(certification_name_id: "2", user_id: "1", expiration_date: "2012-09-05")
    Certification.create!(certification_name_id: "3", user_id: "1", expiration_date: "2012-09-05")

  end
end