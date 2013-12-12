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
                         admin: true)
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
                   shirt_size: "M")
    end
  end
end