FactoryGirl.define do
  factory :account do
    name                  "City of Lakewood"
  end

  factory :user do
    first_name     				"First"
    last_name							"Currin"
    email    							"newfactory@example.com"
    password 							"foobar"
    password_confirmation "foobar"
    admin 								"false"
    active 								"true"
    suit_size 						"M"
    shirt_size 						"M"
    sex 									"M"
    date_of_birth 				"1985-12-24"
    date_of_hire 					"2013-09-01"
    phone_number 					"6613339902"
    account_id            "1"
  end

  factory :admin do
    admin true
  end

  factory :certification_name do
    name                  "CPR/AED"
  end
end