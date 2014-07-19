namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do

    puts "\n\n"
    puts '--------------------------------------------------------------------'
    puts '|                       Reset Demo Enviorment                      |'
    puts '--------------------------------------------------------------------'

    Rake.application['db:reset'].invoke

    puts "\n"
    puts '--------------------------------------------------------------------'
    puts '|                     Generate Demo Enviorment                     |'
    puts '--------------------------------------------------------------------'

    puts "Accounts\n"
    Account.create(name: 'City of Lakewood',
                   time_zone: 'Mountain Time (US & Canada)')
    print '.'
    Account.create(name: 'Foothills',
                   time_zone: 'Mountain Time (US & Canada)')
    print '.'
    Account.create(name: 'Empty',
                   time_zone: 'Mountain Time (US & Canada)')
    print '.'

    puts "\nLocations\n"
    Location.create(name: 'Green Mountain Recreation Center',
                    account_id: 1)
    print '.'
    Location.create(name: 'Link Recreation Center',
                    account_id: 1)
    print '.'
    Location.create(name: 'Carmody Recreation Center',
                    account_id: 1)
    print '.'
    Location.create(name: 'Whitlock Recreation Center',
                    account_id: 1)
    print '.'
    Location.create(name: 'Ridge Recreation Center',
                    account_id: 2)
    print '.'

    puts "\nPools\n"
    Pool.create(name: 'Big',  location_id: Location.first.id)
    print '.'
    Pool.create(name: 'Baby', location_id: Location.first.id)
    print '.'
    Pool.create(name: 'Link', location_id: Location.find(2).id)
    print '.'

    puts "\nSlides\n"
    Slide.create(name: 'Yellow', location_id: Location.first.id)
    print '.'
    Slide.create(name: 'Red',    location_id: Account.find(2).locations.first.id)
    print '.'

    puts "\nPositions\n"
    Position.create(name: 'Lifeguard',
                    account_id: 1)
    print '.'
    Position.create(name: 'MOD',
                    account_id: 1)
    print '.'
    Position.create(name: 'WSI',
                    account_id: 1)
    print '.'

    puts "\nSkill Levels\n"
    SkillLevel.create(name: 'Level 1',
                      account_id: 1)
    print '.'
    SkillLevel.create(name: 'Level 2',
                      account_id: 1)
    print '.'
    SkillLevel.create(name: 'Level 3',
                      account_id: 1)
    print '.'

    puts "\nPackages\n"
    Package.create(name: '1 lesson ($15.00)',
                   account_id: 1)
    print '.'
    Package.create(name: '3 lessons ($40.00)',
                   account_id: 1)
    print '.'
    Package.create(name: '10 lessons ($100.00)',
                   account_id: 1)
    print '.'

    User.create!(first_name:             'First',
                 nickname:               'Dubs',
                 last_name:              'Last',
                 phone_number:           '303-123-8888',
                 secondary_phone_number: '303-123-4567',
                 email:                  'example@affektive.com',
                 password:               'foobar22',
                 password_confirmation:  'foobar22',
                 date_of_birth:          '1992-09-15',
                 sex:                    'F',
                 address1:               '14277 E Warren Dr.',
                 address2:               'Unit B',
                 city:                   'Lakewood',
                 state:                  'CO',
                 zipcode:                '80228',
                 shirt_size:             'M',
                 suit_size:              'M',
                 femalesuit:             '30',
                 emergency_first:        'Lydia',
                 emergency_last:         'Campbell',
                 emergency_phone:        '303-222-1313',
                 location_id:            1,
                 position_id:            2,
                 employee_id:            1313,
                 grouping:               'West',
                 date_of_hire:           '2008-07-01',
                 payrate:                '9.50',
                 admin:                  true,
                 active:                 true,
                 account_id:             1,
                 private_lesson_access:  true)

    puts "\nUsers\n"

    100.times do |n|
      print '.'

      User.create!(first_name: Faker::Name.first_name,
                   nickname: Faker::Name.name,
                   last_name: Faker::Name.last_name,
                   phone_number: Faker::PhoneNumber.phone_number,
                   secondary_phone_number: Faker::PhoneNumber.phone_number,
                   email: Faker::Internet.email,
                   password: 'password',
                   password_confirmation: 'password',
                   date_of_birth: '1992-09-15',
                   sex: %w(M F).sample,
                   address1: Faker::Address.street_address,
                   address2: Faker::Address.secondary_address,
                   city: Faker::Address.city,
                   state: Faker::Address.state_abbr,
                   zipcode: Faker::Address.zip_code,
                   shirt_size: %w(XS S M L XL).sample,
                   suit_size: %w(XS S M L XL).sample,
                   femalesuit: [28, 30, 32, 34, 36, 38, 40].sample,
                   location_id: rand(2) + 1,
                   emergency_first: Faker::Name.first_name,
                   emergency_last: Faker::Name.last_name,
                   emergency_phone: Faker::PhoneNumber.phone_number,
                   position_id: rand(3) + 1,
                   employee_id: rand(1000),
                   grouping: %w(North West East South).sample,
                   date_of_hire: '2008-07-01',
                   payrate: [8.00, 8.50, 9.00, 9.50, 10.00, 10.50].sample,
                   admin: false,
                   active: [true, false].sample,
                   account_id: 1,
                   private_lesson_access:  false
                   )
    end

    puts "\nCertifications\n"

    CertificationName.create!(name: 'CPR_AED',
                              account_id: 1)
    print '.'
    CertificationName.create!(name: 'LGI',
                              account_id: 1)
    print '.'
    CertificationName.create!(name: 'WSI',
                              account_id: 1)
    print '.'

    puts "\nAssign certifications to users\n"

    10.times do |n|
      print '...'

      Certification.create!(certification_name_id: 1,
                            user_id: n + 1,
                            expiration_date: Date.today + rand(365).day,
                            issue_date: Date.today + rand(365).day)

      Certification.create!(certification_name_id: 2,
                            user_id: n + 1,
                            expiration_date: Date.today + rand(365).day,
                            issue_date: Date.today + rand(365).day)

      Certification.create!(certification_name_id: 3,
                            user_id: n + 1,
                            expiration_date: Date.today + rand(365).day,
                            issue_date: Date.today + rand(365).day)
    end

    puts "\nPrivate Lessons\n"

    5.times do |n|
      print '.'
      PrivateLesson.create!(parent_first_name: Faker::Name.first_name,
                            parent_last_name: Faker::Name.last_name,
                            email: Faker::Internet.email,
                            phone_number: Faker::PhoneNumber.phone_number,
                            contact_method: %w(Call Email Text).sample,
                            location_id: rand(3) + 1,
                            package_id: rand(2) + 1,
                            account_id: 1)
    end

    puts "\nParticipants\n"

    5.times do |n|
      print '.'
      Participant.create!(private_lesson_id: n,
                          first_name: Faker::Name.first_name,
                          last_name: Faker::Name.last_name,
                          age: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].sample,
                          sex: %w(M F).sample,
                          skill_level_id: rand(2) + 1)
    end

    puts "\nChemical Records\n"

    25.times do |n|
      print '.'
      si_status = ['Severe Corrosion', 'Moderate Corrosion', 'Mild Corrosion',
                   'Balanced', 'Some Faint Coating', 'Mild Scale Coating',
                   'Mild to Moderate Coatings', 'Moderate Scale Forming',
                   'Severe Scale Forming']
      si_recommendation = ['Treatment Recommended', 'Treatment May Be Needed',
                           'Probably No Treatment', 'No Treatment',
                           'Treatment May Be Needed', 'Treatment Recommended']
      water_clarity = %w(Clear Cloudy)
      free_cl_ppm = rand(2) + 1
      combined_cl_ppm = rand(2) + 1

      ChemicalRecord.create!(free_chlorine_ppm: free_cl_ppm,
                             combined_chlorine_ppm: combined_cl_ppm,
                             total_chlorine_ppm: free_cl_ppm + combined_cl_ppm,
                             ph: [6.8, 6.9, 7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6,
                                  7.7, 7.8, 7.9, 8.0].sample,
                             alkalinity: [30, 40, 50, 60, 70, 80, 90, 100, 110,
                                          120, 130].sample,
                             calcium_hardness: [60, 80, 100, 120, 140, 160,
                                                180, 200].sample,
                             pool_temp: [81, 82, 83, 84, 85, 86].sample,
                             air_temp: [75, 76, 77, 78, 79, 80].sample,
                             water_clarity: water_clarity.sample,
                             time_stamp: Time.now,
                             si_index: [-1, -0.5, -0.3, 0, 0.3, 0.5, 1].sample,
                             si_status: si_status.sample,
                             si_recommendation: si_recommendation.sample,
                             pool_id: Pool.take(3).map(&:id).sample,
                             location_id: Location.take(2).map(&:id).sample,
                             user_id: [1, 2, 3, 4, 5].sample)
    end

    puts "\nHelpDesk Issues\n"

    10.times do |n|
      print '.'
      name = ['Broken Pipe', 'Loose Door', 'Leak in Sink',
              'Stiff Diving Board', 'Broken Phone', 'Unorganized Chemicals',
              'Clean Pumproom', 'Rewrap Lane Lines']
      HelpDesk.create!(name: name.sample,
                       urgency: %w(Low Medium High).sample,
                       issue_status: [true, false].sample,
                       location_id: [1, 2, 3, 4].sample,
                       user_id: n + 1,
                       closed_user_id: n + 2
                       )
    end

    puts "\n\nShift Reports"

    10.times do |n|
      print '.'
      ShiftReport.create!(user_id: n + 1,
                          location_id: [1, 2].sample,
                          content: 'Blah Blah Blah',
                          report_filed: [true, false].sample,
                        )
    end

    puts "\n\nTime Off Requests"

    15.times do |n|
      print '.'
      TimeOffRequest.create!(user_id: n + 1,
                             starts_at: '2014-07-01 17:21:21',
                             ends_at: '2014-07-04 17:30:25',
                             reason: 'Blah Blah Blah',
                             approved: false,
                             active: true,
                             location_id: rand(3) + 1
                            )
    end

    puts "\n\nMy Time Off Requests"

    print '.'
    TimeOffRequest.create!(user_id: 1,
                           starts_at: '2014-09-03 11:21:21',
                           ends_at: '2014-10-17 12:30:25',
                           reason: 'Blah Blah Blah',
                           approved: false,
                           active: false,
                           location_id: rand(3) + 1
                          )

    print '.'
    TimeOffRequest.create!(user_id: 1,
                           starts_at: '2014-04-03 11:21:21',
                           ends_at: '2014-6-17 12:30:25',
                           reason: 'Blah Blah Blah',
                           approved: false,
                           active: true,
                           location_id: rand(3) + 1
                          )

    print '.'
    TimeOffRequest.create!(user_id: 1,
                           starts_at: '2014-02-03 13:21:21',
                           ends_at: '2014-7-17 15:30:25',
                           reason: 'Blah Blah Blah',
                           approved: true,
                           approved_at: '2014-01-27 18:15:20',
                           processed_by_last_name: 'Snow',
                           processed_by_first_name: 'John',
                           active: false,
                           location_id: rand(3) + 1
                          )


    puts "\n\nSlide Inspections"

    8.times do |n|
      print '.'
      SlideInspection.create!(slide_id: Slide.first.id,
                              user_id: rand(80) + 1,
                              notes: 'all is good',
                              all_ok: true)
    end

    8.times do |n|
      print '.'
      SlideInspection.create!(slide_id: Slide.find(2).id,
                              user_id: rand(80) + 1,
                              notes: 'all is good',
                              all_ok: true)
    end

    2.times do |n|
      print '.'
      SlideInspection.create!(slide_id: Slide.first.id,
                              user_id: rand(80) + 1,
                              notes: 'broken bolts',
                              all_ok: false)
    end

    puts "\n\nShifts"

    100.times do |n|
      print '.'
      Shift.create!(user_id: rand(100) + 1,
                              location_id: rand(3) + 1,
                              position_id: rand(3) + 1,
                              start_time: Time.now - rand(3).hours,
                              end_time: Time.now + rand(3).hours)
    end

    100.times do |n|
      print '.'
      Shift.create!(user_id: rand(100) + 1,
                              location_id: rand(3) + 1,
                              position_id: rand(3) + 1,
                              start_time: Time.now + rand(3).hours + 12.hours,
                              end_time: Time.now + rand(5).hours + 12.hours)
    end

    20.times do |n|
      print '.'
      Shift.create!(user_id: rand(100) + 1,
                              location_id: rand(3) + 1,
                              position_id: rand(3) + 1,
                              start_time: Time.now + rand(3).hours - 24.hours,
                              end_time: Time.now + rand(5).hours - 24.hours)
    end

    20.times do |n|
      print '.'
      Shift.create!(user_id: rand(100) + 1,
                              location_id: rand(3) + 1,
                              position_id: rand(3) + 1,
                              start_time: Time.now + rand(3).hours - 72.hours,
                              end_time: Time.now + rand(5).hours - 72.hours)
    end

    20.times do |n|
      print '.'
      Shift.create!(user_id: rand(100) + 1,
                              location_id: rand(3) + 1,
                              position_id: rand(3) + 1,
                              start_time: Time.now + rand(3).hours - 96.hours,
                              end_time: Time.now + rand(5).hours - 96.hours)
    end

    20.times do |n|
      print '.'
      Shift.create!(user_id: rand(100) + 1,
                              location_id: rand(3) + 1,
                              position_id: rand(3) + 1,
                              start_time: Time.now + rand(3).hours - 120.hours,
                              end_time: Time.now + rand(5).hours - 120.hours)
    end

    20.times do |n|
      print '.'
      Shift.create!(user_id: rand(100) + 1,
                              location_id: rand(3) + 1,
                              position_id: rand(3) + 1,
                              start_time: Time.now + rand(3).hours - 144 .hours,
                              end_time: Time.now + rand(5).hours - 144.hours)

    puts "\n\nAvailabilities"

    100.times do |n|
      print '.'
      Availability.create!(user_id: rand(100) + 1,
                           day: rand(6),
                           start_time: Time.now - rand(3).hours - 72.hours,
                           end_time: Time.now + rand(3).hours - 72.hours)
    end

    100.times do |n|
      print '.'
      Availability.create!(user_id: rand(100) + 1,
                           day: rand(6),
                           start_time: Time.now + rand(3).hours + 16.hours,
                           end_time: Time.now + rand(5).hours + 16.hours)

    end

    puts "\n\n"
    puts '--------------------------------------------------------------------'
    puts '|   ( D | i | g | i | Q | u | a | t | i | c | s | 2 | 0 | 1 | 4 )  |'
    puts '--------------------------------------------------------------------'
    puts "\n\n"

  end
end
