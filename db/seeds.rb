require_relative 'seed_data'
require 'faker'
require 'json'


#Reading Jsons

filepath = 'db/offices_projects.json'
serialized_offices = File.read(filepath)
offices = JSON.parse(serialized_offices)

filepath = 'db/jobs.json'
serialized_jobs = File.read(filepath)
jobs = JSON.parse(serialized_jobs)

filepath = 'db/events.json'
serialized_events = File.read(filepath)
events = JSON.parse(serialized_events)

filepath = 'db/posts.json'
serialized_posts = File.read(filepath)
posts = JSON.parse(serialized_posts)

#N of seeds

n_offices = offices.size
n_team_members = TEAM_MEMBER_NAME.size
n_users = 15
n_posts = posts.size
n_events = events.size
n_experiences_per_user = 3
n_jobs = jobs.size
n_ratings = 15
n_rsvps = 15
n_comments = 15

#Seedings

phase = "office"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="


offices.each do |office|
  Office.create(name: office["name"],
                location: office["location"],
                url: office["url"],
                description: OFFICE_DESCRIPTIONS.sample,
                banner_url: office["banner_url"])
                # cl_img_tag: "offices/office#{rand(1..48)}",
                # cl_img_project_tag: "projects/project#{rand(1..10)}")
                puts "=== Office seeded ======                ==="

    office["projects"].each do |project|
                OfficeProject.create(office_id: project["office_id"],
                                      project_name: project["project_name"],
                                      project_img_url: project["project_img_url"],
                                      project_year: project["project_year"],
                                      project_typology: project["project_typology"])
                puts "===               ====== Project seeded ==="
              end
end
puts "



"
puts "Random #{phase} sample:"
p Office.find(1)
puts "



"
phase = "team user"
puts "===:::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

TEAM_MEMBER_NAME.each do |name|
  first_name = name.split[0]
  last_name = name.split[1]
  User.create(email: "#{first_name.downcase}@test.com",
              password: '123456',
              first_name: first_name,
              last_name: last_name,
              description: Faker::Lorem.paragraph(sentence_count: 20),
              cl_img_tag: "users/#{first_name}",
              seed_portfolio: "portfolios/portfolio1")

puts "===#{terminal_counter} out of #{n_team_members}, #{name}'s Account Created ---> Email: '#{name}@test.com', Password: '123456'==="
terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p User.find(1)
puts "



"
phase = "user"
puts "===:::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

n_users.times do
  User.create(email: Faker::Internet.email,
              password: '123456',
              first_name: Faker::Name.first_name ,
              last_name: Faker::Name.last_name,
              description: USER_DESCRIPTIONS.sample,
              cl_img_tag: "users/user#{rand(1..12)}",
              seed_portfolio: ["portfolios/portfolio1", "portfolios/portfolio2", "portfolios/portfolio3"])

  puts "=== #{terminal_counter} out of #{n_users} Users seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p User.find(1)
puts "



"
phase = "post"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

posts.each do |post|
  Post.create(title: post["title"],
              date: post["date"],
              content: post["content"],
              user_id: rand(1..n_users))

  puts "=== #{terminal_counter} out of #{n_posts} Posts seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p Post.find(1)
puts "



"
phase = "event"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

events.each do |event|
  Event.create(date_time: event["date"] + " " + event["time_start"] + " - " + event["time_end"],
               title: event["title"],
               location: event["location"],
               venue: event["venue"],
               description: event["description"],
               user_id: rand(1..n_users),
               cl_img_tag: "events/event#{event["id"]}")

  puts "=== #{terminal_counter} out of #{n_events} Events seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p Event.find(1)
puts "



"
phase = "experience"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

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
    puts "===                                      === #{terminal_counter} out of #{n_experiences_per_user} #{phase} seeded ==="
    terminal_counter += 1
    end_year -= 2
    end
  experienced_user += 1
  puts "=== user #{experienced_user} with #{n_experiences_per_user}s #{phase} seeded ===                                   ==="
end
puts "



"
puts "Random #{phase} sample:"
p Experience.where(user_id: 3)
puts "



"
phase = "jobs"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

jobs.each do |job|
  Opening.create!(date: job["date"],
                 job_position: job["job_position"],
                 description: JOB_DESCRIPTIONS.sample,
                 office_id: rand(1..n_offices))

  puts "=== #{terminal_counter} out of #{n_jobs} #{phase} seeded ==="
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Opening.find(1)
puts "



"
phase = "rating"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

n_ratings.times do
  Rating.create(culture: rand(1..5),
                salary: rand(1..5),
                architecture: rand(1..5),
                office_id: rand(1..n_offices))

  puts "=== #{terminal_counter} out of #{n_ratings}s #{phase} seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p Rating.find(1)
puts "



"
phase = "rsvp"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

n_rsvps.times do
  Rsvp.create(user_id: rand(1..n_users),
              event_id: rand(1..n_events))

  puts "=== #{terminal_counter} out of #{n_rsvps} #{phase}s seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p Rsvp.find(1)
puts "



"
phase = "comment"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

n_comments.times do
  # Post Comment
  Comment.create(post_id: rand(1..10),
                  user_id: rand(1..n_users),
                  date: Faker::Date.between(from: '2017-09-23', to: '2020-04-25'),
                  content: COMMENTS.sample)

  # Office Comment
  Comment.create(office_id: rand(1..10),
                  user_id: rand(1..n_users),
                  date: Faker::Date.between(from: '2017-09-23', to: '2020-04-25'),
                  content: COMMENTS.sample)

  # Event Comment
  Comment.create(event_id: rand(1..10),
                  user_id: rand(1..n_users),
                  date: Faker::Date.between(from: '2017-09-23', to: '2020-04-25'),
                  content: COMMENTS.sample)

  puts "=== #{terminal_counter * 3} out of #{n_comments * 3} #{phase}s seeded ==="
  terminal_counter += 1
end
puts ""
puts "Random #{phase} sample:"
p Comment.find(1)
puts ""


puts "Sumber of seeds created:
--Offices: #{n_offices}
--Team Member Accounts #{n_team_members}
--User Acoounts #{n_users}
--Posts: #{n_posts}
--Events: #{n_events}
--Experiences: #{n_experiences_per_user}
--Jobs: #{n_jobs}
--Ratings: #{n_ratings}
--RSVPS: #{n_rsvps}
--Comments: #{n_comments}"

