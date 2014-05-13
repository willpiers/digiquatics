FactoryGirl.define do
  factory :account do
    name 'City of Lakewood'
    time_zone 'Mountain Time (US & Canada)'
  end

  factory :location do
    name 'Carmody Rec Center'
    account_id 1
  end

  factory :pool do
    name 'Baby'
    location_id 1
  end

  factory :position do
    name 'Lifeguard'
    account_id 1
  end

  factory :user do
    first_name 'Josh'
    last_name 'Duffy'
    email 'newuser@example.com'
    password 'foobar77'
    password_confirmation 'foobar77'
    admin false
    active true
    suit_size 'M'
    shirt_size 'M'
    sex 'F'
    date_of_birth '1985-12-24'
    date_of_hire '2013-09-01'
    phone_number 1234
    account_id 1
    location_id 1
    position_id 1
    employee_id 1313
  end

  factory :admin, class: User do
    first_name 'Michael'
    last_name 'Pierce'
    email 'newadmin@example.com'
    password 'foobar77'
    password_confirmation 'foobar77'
    admin true
    active true
    suit_size 'M'
    shirt_size 'M'
    sex 'M'
    date_of_birth '1985-12-24'
    date_of_hire '2013-09-01'
    phone_number 1234
    account_id 1
    location_id 1
    position_id 1
  end

  factory :certification do
    certification_name_id 1
    user_id 1
    issue_date '2011-09-15'
    expiration_date '2012-09-15'
  end

  factory :certification_name do
    name 'CPR/AED'
    account_id 1
  end

  factory :private_lesson do
    account_id 1
    parent_first_name 'Trent'
    parent_last_name 'Allen'
    email 'michael@affektive.com'
    phone_number 1234
    day 'Mon'
    time 'AM'
    preferred_location 1
    user_id 1
    contact_method 'Call'
    number_lessons 3
    instructor_gender 'F'
    notes 'None at this moment'
    lesson_objective 'Starts & Turns'
  end

  factory :participant do
    private_lesson_id 1
    first_name 'Michael'
    last_name 'Pierce'
    age 12
    sex 'M'
  end

  factory :chemical_record do
    time_stamp DateTime.now
    user_id 1
    pool_id 1
  end

  factory :slide do
    location_id 1
    name 'Big Yellow'
  end

  factory :slide_inspection do
    slide_id 1
    user_id 1
  end

  factory :slide_inspection_task do
    slide_inspection_id 1
    task_name 'bolts tight'
    completed true
  end

  factory :help_desk do
    name 'Broken pipe'
    urgency 'Low'
    issue_status true
    location_id 1
    user_id 1
    closed_user_id 2
  end

  factory :shift_report do
    content 'All was good during my shift at the pool'
    report_filed true
    user_id 1
    location_id 1
  end
end
