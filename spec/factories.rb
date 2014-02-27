FactoryGirl.define do
  factory :account do
    name      'City of Lakewood'
    time_zone 'Mountain Time (US & Canada)'
  end

  factory :location do
    name       'Carmody Rec Center'
    account_id 1
  end

  factory :pool do
    name        'Baby'
    location_id 1
  end

  factory :position do
    name       'Lifeguard'
    account_id 1
  end

  factory :user do
    first_name            'Josh'
    last_name             'Duffy'
    email                 'newuser@example.com'
    password              'foobar77'
    password_confirmation 'foobar77'
    admin                 false
    active                true
    suit_size             'M'
    shirt_size            'M'
    sex                   'F'
    date_of_birth         '1985-12-24'
    date_of_hire          '2013-09-01'
    phone_number          1234
    account_id            1
    location_id           1
    position_id           1
    employee_id          1313
  end

  factory :admin, class: User do
    first_name            'Michael'
    last_name             'Pierce'
    email                 'newadmin@example.com'
    password              'foobar77'
    password_confirmation 'foobar77'
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
    issue_date            '2011-09-15'
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
    day                    'Mon'
    time                   'AM'
    notes                  'None at this moment'
    preferred_location     1
    user_id                1
  end

  factory :chemical_record do
    date_stamp        DateTime.now
    time_stamp        DateTime.now
    user_id           1
    pool_id           1
  end
end
