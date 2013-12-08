FactoryGirl.define do
  factory :user do
    first_name     				"Joe"
    last_name							"Currin"
    email    							"joe@affektive.com"
    password 							"foobar"
    password_confirmation "foobar"
    admin 								"true"
    active 								"true"
    suit_size 						"M"
    shirt_size 						"M"
    sex 									"M"
    date_of_birth 				"1985-12-24"
    date_of_hire 					"2013-09-01"
    phone_number 					"6613339902"
  end
end