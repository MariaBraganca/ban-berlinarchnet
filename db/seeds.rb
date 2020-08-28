require_relative 'seed_scrape_cleaner'
require_relative 'seed_data'
require 'open-uri'
require 'nokogiri'
require 'faker'

n_offices = CLEAN_OFFICE_ARRAY.size
n_team_members = TEAM_MEMBER_NAME.size
n_users = 15
n_posts = 15
n_events = 15
n_experiences_per_user = 3
n_openings = 15
n_ratings = 15
n_rsvps = 15
n_comments = 15

phase = "office"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

CLEAN_OFFICE_ARRAY.each do |elementos|
  Office.create(name: elementos[:external_name],
             location: elementos[:external_location],
             description: OFFICE_DESCRIPTIONS.sample,
             cl_img_tag: "offices/office#{rand(1..48)}",
             url: elementos[:external_url],
             cl_img_project_tag: "projects/project#{rand(1..10)}")
  puts "________#{terminal_counter}__ out of #{n_offices}______Offices Saved!_____________________"
  terminal_counter += 1
end

puts ""
puts ""
puts "Random #{phase} sample:"
p Office.find(rand(1..n_offices))
puts ""
puts ""
puts ""
phase = "team user"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

TEAM_MEMBER_NAME.each do |name|
  User.create(email: "#{name}@test.com",
              password: '123456',
              first_name: name.capitalize,
              last_name: 'Lastname',
              description: Faker::Lorem.paragraph(sentence_count: 20),
              cl_img_tag: "logo/logo1",
              seed_portfolio: "portfolios/portfolio1")
puts "___#{terminal_counter} out of #{n_team_members}, #{name}'s Account Created ---> Email: '#{name}@test.com', Password: '123456'___"
terminal_counter += 1
end

puts ""
puts ""
puts "Random #{phase} sample:"
p User.find(rand(1..n_team_members))
puts ""
puts ""
puts ""


phase = "user"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

n_users.times do
  User.create(email: Faker::Internet.email,
              password: '123456',
              first_name: Faker::Name.first_name ,
              last_name: Faker::Name.last_name,
              description: Faker::Lorem.paragraph(sentence_count: 20),
              cl_img_tag: "users/user#{rand(1..12)}",
              seed_portfolio: "portfolios/portfolio1")
  puts "___#{terminal_counter} out of #{n_users} Fake users created___"
  terminal_counter += 1
end

puts ""
puts ""
puts "Random #{phase} sample:"
p User.find(rand(1..n_users))
puts ""
puts ""
puts ""


phase = "post"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

n_posts.times do
  Post.create(title: Faker::Book.title,
              date: Faker::Time.backward(days: rand(1..10), format: :long),
              content: Faker::Lorem.paragraph(sentence_count: 50),
              user_id: rand(1..n_users))

  puts "___#{terminal_counter} out of #{n_posts} Fake Posts created___"
  terminal_counter += 1
end

puts ""
puts ""
puts "Random #{phase} sample:"
p Post.find(rand(1..n_posts))
puts ""
puts ""
puts ""
puts ""
puts ""



phase = "event"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

n_events.times do
  Event.create(date_time: Faker::Time.forward(days: rand(1..30),  period: :evening, format: :long),
               location: BERLIN_ADDRESES.sample,
               description: Faker::Lorem.paragraph(sentence_count: 50),
               user_id: rand(1..n_users),
               title: Faker::Book.title,
               cl_img_tag: "events/event#{rand(1..2)}")

  puts "___#{terminal_counter} out of #{n_events} Fake Events created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Event.find(rand(1..n_events))
puts ""
puts ""
puts ""
puts ""
puts ""


phase = "experience"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1
experienced_user = 1
n_users.times do
  end_year = rand(2019..2022)
  n_experiences_per_user.times do
    Experience.create(end_date: Faker::Date.in_date_period(year: end_year, month: rand(1..5)),
                      start_date: Faker::Date.in_date_period(year: (end_year - 2), month: rand(6..12)),
                      job_position: "#{Faker::Job.employment_type} #{Faker::Job.position} Architect",
                      office_id: rand(1..n_offices),
                      user_id: experienced_user)
    puts "___#{terminal_counter} out of #{n_experiences_per_user} Fake #{phase} created___"
    terminal_counter += 1
    end_year -= 2
    end
  experienced_user += 1
  puts "___#{experienced_user} user with #{n_experiences_per_user} Fake #{phase} created___"
end
puts ""
puts "Random #{phase} sample:"
p Experience.find(rand(1..n_experiences_per_user))
p Experience.where(user_id: 3)
puts ""
puts ""
puts ""
puts ""
puts ""



phase = "opening"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

n_openings.times do
  Opening.create(date: Faker::Date.in_date_period(year: 2020, month: rand(9..12)),
                 job_position: "#{Faker::Job.employment_type} #{Faker::Job.seniority} #{Faker::Job.position} Architect",
                 description: Faker::Lorem.paragraph(sentence_count: 50),
                 office_id: rand(1..n_offices))

  puts "___#{terminal_counter} out of #{n_openings} Fake #{phase} created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Opening.find(rand(1..n_openings))
puts ""
puts ""
puts ""
puts ""
puts ""


phase = "rating"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

n_ratings.times do
  Rating.create(culture: rand(1..5),
                salary: rand(1..5),
                architecture: rand(1..5),
                office_id: rand(1..n_offices))

  puts "___#{terminal_counter} out of #{n_ratings} Fake #{phase} created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Rating.find(rand(1..n_ratings))
puts ""
puts ""
puts ""
puts ""
puts ""


phase = "rsvp"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

n_rsvps.times do
  Rsvp.create(user_id: rand(1..n_users),
              event_id: rand(1..n_events))

  puts "___#{terminal_counter} out of #{n_rsvps} Fake #{phase} created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Rsvp.find(rand(1..n_rsvps))
puts ""
puts ""
puts ""
puts ""
puts ""


phase = "comment"
puts ":::::::::#{phase}:::::::::::#{phase}::::::::::::::::::::#{phase}::::::::::::#{phase}::::::::::::"

terminal_counter = 1

n_comments.times do
  # Post Comment
  Comment.create!(post_id: rand(1..n_posts),
                  user_id: rand(1..n_users),
                  date: Faker::Time.forward(days: rand(1..30),  period: :evening, format: :long),
                  content: Faker::Lorem.paragraph(sentence_count: 10))

  # Office Comment
  Comment.create!(office_id: rand(1..n_offices),
                  user_id: rand(1..n_users),
                  date: Faker::Time.forward(days: rand(1..30),  period: :evening, format: :long),
                  content: Faker::Lorem.paragraph(sentence_count: 10))

  # Event Comment
  Comment.create!(event_id: rand(1..n_events),
                  user_id: rand(1..n_users),
                  date: Faker::Time.forward(days: rand(1..30),  period: :evening, format: :long),
                  content: Faker::Lorem.paragraph(sentence_count: 10))

  puts "___#{terminal_counter * 3} out of #{n_comments * 3} Fake Comments created___"
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Comment.find(rand(1..n_comments))
puts ""


puts "Sumber of seeds created:
--Offices: #{n_offices}
--Team Member Accounts #{n_team_members}
--User Acoounts #{n_users}
--Posts: #{n_posts}
--Events: #{n_events}
--Experiences: #{n_experiences_per_user}
--Openings: #{n_openings}
--Ratings: #{n_ratings}
--RSVPS: #{n_rsvps}
--Comments: #{n_comments}"

