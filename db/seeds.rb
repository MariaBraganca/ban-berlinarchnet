require_relative 'seed_scrape_cleaner'
require_relative 'seed_data'
require 'open-uri'
require 'nokogiri'
require 'faker'

phase = "office"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
office_task_repetition = CLEAN_OFFICE_ARRAY.size

CLEAN_OFFICE_ARRAY.each do |elementos|
  Office.create(name: elementos[:external_name],
             location: elementos[:external_location],
             description: OFFICE_DESCRIPTIONS.sample,
             cl_img_tag: "offices/office#{rand(1..48)}",
             url: elementos[:external_url])
  puts "________#{terminal_counter}__ out of #{office_task_repetition}______Offices Saved!_____________________"
  terminal_counter += 1
end

puts ""
puts ""
puts "Random #{phase} sample:"
p Office.find(rand(1..office_task_repetition))
puts ""
puts ""
puts ""
phase = "team user"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = TEAM_MEMBER_NAME.size

TEAM_MEMBER_NAME.each do |name|
  User.create(email: "#{name}@test.com",
              password: '123456',
              first_name: name.capitalize,
              last_name: 'Lastname',
              description: 'Test')
puts "___#{terminal_counter} out of #{task_repetition}, #{name}'s Account Created ---> Email: '#{name}@test.com', Password: '123456'___"
terminal_counter += 1
end

puts ""
puts ""
puts "Random #{phase} sample:"
p User.find(rand(1..task_repetition))
puts ""
puts ""
puts ""

phase = "user"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = 10

task_repetition.times do
  User.create(email: Faker::Internet.email,
              password: '123456',
              first_name: Faker::Name.first_name ,
              last_name: Faker::Name.last_name,
              description: 'Test',
              cl_img_tag: "users/user#{rand(1..3)}")
  puts "___#{terminal_counter} out of #{task_repetition} Fake users created___"
  terminal_counter += 1
end

puts ""
puts ""
puts "Random #{phase} sample:"
p User.find(rand(1..task_repetition))
puts ""
puts ""
puts ""

phase = "post"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = 30

task_repetition.times do
  Post.create(title: Faker::Book.title,
              date: Faker::Time.backward(days: rand(1..10), format: :long),
              content: Faker::Lorem.paragraph(sentence_count: 50),
              user_id: rand(1..10))

  puts "___#{terminal_counter} out of #{task_repetition} Fake Posts created___"
  terminal_counter += 1
end

puts ""
puts ""
puts "Random #{phase} sample:"
p Post.find(rand(1..task_repetition))
puts ""
puts ""
puts ""
puts ""
puts ""

phase = "event"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = 30

task_repetition.times do
  Event.create(date_time: Faker::Time.forward(days: rand(1..30),  period: :evening, format: :long),
               location: BERLIN_ADDRESES.sample,
               description: Faker::Lorem.paragraph(sentence_count: 50),
               user_id: rand(1..10),
               title: Faker::Book.title,
               cl_img_tag: "events/event#{rand(1..2)}")

  puts "___#{terminal_counter} out of #{task_repetition} Fake Events created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Event.find(rand(1..task_repetition))
puts ""
puts ""
puts ""
puts ""
puts ""

phase = "experience"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = 30

task_repetition.times do
  Experience.create(start_date: Faker::Date.in_date_period(year: 2018, month: 2),
                    end_date: Faker::Date.in_date_period(year: 2020, month: 6),
                    job_position: "#{Faker::Job.employment_type} #{Faker::Job.seniority} #{Faker::Job.position} Architect",
                    office_id: rand(1..office_task_repetition),
                    user_id: rand(1..10))

  puts "___#{terminal_counter} out of #{task_repetition} Fake #{phase} created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Experience.find(rand(1..task_repetition))
puts ""
puts ""
puts ""
puts ""
puts ""

phase = "opening"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = 30

task_repetition.times do
  Opening.create(date: Faker::Date.in_date_period(year: 2020, month: rand(9..12)),
                 job_position: "#{Faker::Job.employment_type} #{Faker::Job.seniority} #{Faker::Job.position} Architect",
                 description: Faker::Lorem.paragraph(sentence_count: 50),
                 office_id: rand(1..office_task_repetition))

  puts "___#{terminal_counter} out of #{task_repetition} Fake #{phase} created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Opening.find(rand(1..task_repetition))
puts ""
puts ""
puts ""
puts ""
puts ""

phase = "rating"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = 30

task_repetition.times do
  Rating.create(culture: rand(1..5),
                salary: rand(1..5),
                architecture: rand(1..5),
                office_id: rand(1..office_task_repetition))

  puts "___#{terminal_counter} out of #{task_repetition} Fake #{phase} created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Rating.find(rand(1..task_repetition))
puts ""
puts ""
puts ""
puts ""
puts ""

phase = "rsvp"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = 30

task_repetition.times do
  Rsvp.create(user_id: rand(1..10),
              event_id: rand(1..30))

  puts "___#{terminal_counter} out of #{task_repetition} Fake #{phase} created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Rsvp.find(rand(1..task_repetition))
puts ""
puts ""
puts ""
puts ""
puts ""

phase = "comment"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
task_repetition = 50

task_repetition.times do
  # Post Comment
  Comment.create(post_id: rand(1..30),
                 user_id: rand(1..10),
                 date: Faker::Time.forward(days: rand(1..30),  period: :evening, format: :long),
                 content: Faker::Lorem.paragraph(sentence_count: 10))

  # Office Comment
  Comment.create(office_id: rand(1..rand(1..office_task_repetition)),
                 user_id: rand(1..10),
                 date: Faker::Time.forward(days: rand(1..30),  period: :evening, format: :long),
                 content: Faker::Lorem.paragraph(sentence_count: 10))

  # Event Comment
  Comment.create(event_id: rand(1..30),
                 user_id: rand(1..10),
                 date: Faker::Time.forward(days: rand(1..30),  period: :evening, format: :long),
                 content: Faker::Lorem.paragraph(sentence_count: 10))

  puts "___#{terminal_counter * 3} out of #{task_repetition * 3} Fake Comments created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Comment.find(rand(1..task_repetition))
puts ""


