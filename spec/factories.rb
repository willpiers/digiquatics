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
    email Faker::Internet.email
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
    chemical_records_access true
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
    chemical_records_access true
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
    preferred_location 1
    user_id 1
    contact_method 'Call'
    instructor_gender 'F'
    notes 'None at this moment'
    lesson_objective 'Starts & Turns'
    package_id 1
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

  factory :skill_level do
    name 'Level 1'
    account_id 1
  end

  factory :package do
    name '3 Lessons ($50.00)'
    account_id 1
  end

  factory :shift do
    user_id 1
    location_id 1
    position_id 1
    start_time Time.zone.now
    end_time Time.zone.now + 5.hours
  end

  factory :invalid_shift, parent: :shift do
    user_id nil
  end

  factory :time_off_request do
    user_id 1
    starts_at Time.now
    ends_at Time.zone.now + 5.hours
    reason 'I want to have some time off this weekend.'
    approved false
    approved_by_user_id nil
    approved_at nil
  end

  factory :invalid_time_off_request, parent: :time_off_request do
    user_id nil
    starts_at Time.now
    ends_at Time.zone.now + 5.hours
  end

  factory :availability do
    user_id 1
  end

  factory :invalid_availability, parent: :availability do
    user_id nil
  end

  factory :sub_request do
    shift_id 1
    user_id 1
    processed_on Time.now
    active true
    approved false
    processed_by_user_id nil
  end

  factory :invalid_sub_request, parent: :sub_request do
    shift_id nil
  end
end
