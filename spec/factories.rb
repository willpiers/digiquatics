FactoryGirl.define do
  factory :account do
    name                  'City of Lakewood'
  end

  factory :location do
    name                  'Carmody Rec Center'
    account_id            1
  end

  factory :position do
    name                  'Lifeguard'
    account_id            1
  end

  factory :user do
    first_name     				'Joe'
    last_name							'Currin'
    email    							'newfactory@example.com'
    password 							'foobar'
    password_confirmation 'foobar'
    admin                 false
    active 								true
    suit_size 						'M'
    shirt_size 						'M'
    sex 									'F'
    date_of_birth 				'1985-12-24'
    date_of_hire 					'2013-09-01'
    phone_number 					1234
    account_id            1
    location_id           1
    position_id           1
  end

    factory :admin, class: User do
    first_name            'Joe'
    last_name             'Currin'
    email                 'newfactory@example.com'
    password              'foobar'
    password_confirmation 'foobar'
    admin                 true
    active                true
    suit_size             'M'
    shirt_size            'M'
    sex                   'M'
    date_of_birth         '1985-12-24'
    date_of_hire          '2013-09-01'
    phone_number          1234
    account_id            1
    location_id           1
    position_id           1
  end


  factory :certification do
    certification_name_id 1
    user_id               1
    expiration_date       '2012-09-15'
  end

  factory :certification_name do
    name                  'CPR/AED'
    account_id            1
  end

  factory :private_lesson do
    first_name            'Michael'
    last_name             'Pierce'
    parent_first_name     'Trent'
    parent_last_name      'Allen'
    email                 'michael@affektive.com'
    phone_number          1234
    age                   12
    sex                   'M'
    instructor_gender     'F'
    ability_level          6
    day                    "Mon"
    time                   "AM"
    notes                  "None at this moment"
    preferred_location     1
  end
end
