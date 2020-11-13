require_relative 'seed_data'
require 'faker'
require 'json'


#Reading Jsons

filepath = 'db/offices.json'
serialized_offices = File.read(filepath)
offices = JSON.parse(serialized_offices)

filepath = 'db/offices_berlin.json'
serialized_offices_berlin = File.read(filepath)
offices_berlin = JSON.parse(serialized_offices_berlin)

# filepath = 'db/jobs.json'
# serialized_jobs = File.read(filepath)
# jobs = JSON.parse(serialized_jobs)

filepath = 'db/events.json'
serialized_events = File.read(filepath)
events = JSON.parse(serialized_events)

filepath = 'db/posts.json'
serialized_posts = File.read(filepath)
posts = JSON.parse(serialized_posts)

#N of seeds
n_offices = offices.size
n_offices_berlin = offices_berlin.size
n_team_members = TEAM_MEMBER_NAME.size
n_users = 35
n_posts = posts.size
n_events = events.size
n_experiences_per_user = 3
# n_jobs = jobs.size
n_ratings = 100
n_rsvps = 10
n_comments = 40

#Seedings

phase = "offices"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

offices.each do |office|
  Office.create(name: office["name"],
                location: office["location"],
                url: office["url"],
                description: office["description"],
                banner_url: office["banner_url"])
    unless office["projects"].nil?
      office["projects"].each do |project|
        project["id"] = Office.last.id
        OfficeProject.create( office_id: project["id"],
                              project_name: project["project_name"],
                              project_img_url: project["project_img_url"],
                              project_year: project["project_year"],
                              project_typology: project["project_typology"])
        puts "=== Project seeded ==="
      end
    end
  puts "=== Office seeded <=> #{terminal_counter} out of #{n_offices} ==="
  terminal_counter += 1
end
puts "


"
puts "Random #{phase} sample:"
p Office.find(rand(1..Office.all.count))
puts "


"
phase = "offices in berlin"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

# Offices from Architekturkammer
offices_berlin.each do |office|
  Office.create(name: office["name"],
                location: office["location"],
                url: office["url"])
  puts "=== Office seeded <=> #{terminal_counter} out of #{n_offices_berlin} ==="
  terminal_counter += 1
end
puts "


"
puts "Random #{phase} sample:"
p Office.find(rand(1..Office.all.count))
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
p User.find(rand(1..4))
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
              cl_img_tag: "users/user#{terminal_counter}",
              seed_portfolio: ["portfolios/portfolio1", "portfolios/portfolio2", "portfolios/portfolio3"])

  puts "=== #{terminal_counter} out of #{n_users} Users seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p User.find(rand(1..User.all.count))
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
p Post.find(rand(1..Post.all.count))
puts "



"
phase = "event"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

events.each do |event|
  Event.create!(start_date: event["start_date"],
                end_date:event["end_date"],
                format: event["format"],
                title: event["title"],
                location: event["location"],
                venue: event["venue"],
                online: event["online"],
                online_link: event["online_link"],
                description: event["description"],
                user_id: rand(1..n_users),
                cl_img_tag: "https://res.cloudinary.com/db5jh0zwo/image/upload/v1603105183/events/event#{event["id"]}")

  puts "=== #{terminal_counter} out of #{n_events} Events seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p Event.find(rand(1..Event.all.count))
puts "



"
# terminal_counter = 1
# experienced_user = 1
# n_users.times do
#   binding.pry
#   end_year = rand(2019..2022)
#   n_experiences_per_user.times do
#     Experience.create(end_date: Faker::Date.in_date_period(year: end_year, month: rand(1..5)),
#                       start_date: Faker::Date.in_date_period(year: (end_year - 2), month: rand(6..12)),
#                       job_position: "#{Faker::Job.employment_type} #{Faker::Job.position} Architect",
#                       office_id: rand(1..n_offices),
#                       user_id: experienced_user)
#     puts "===                                   <=> #{terminal_counter} out of #{n_experiences_per_user} #{phase} seeded ==="
#     terminal_counter += 1
#     end_year -= 2
#     end
#   experienced_user += 1
#   puts "=== user #{experienced_user} with #{n_experiences_per_user}s #{phase} seeded <=>                                   ==="
# end
phase = "experience"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="
puts "

"
terminal_counter = 1
User.all.each do |user|
  office_ids = Office.pluck(:id)
  end_year = rand(2019..2022)
  3.times do
    office_id = office_ids.sample
    Experience.create(end_date: Faker::Date.in_date_period(year: end_year, month: rand(1..5)),
                      start_date: Faker::Date.in_date_period(year: (end_year - 2), month: rand(6..12)),
                      job_position: "#{Faker::Job.employment_type} #{Faker::Job.position} Architect",
                      office_id: office_id,
                      user: user)
    puts "=== #{terminal_counter} out of #{(User.count * 3) } #{phase}s seeded ==="
    terminal_counter += 1
    office_ids.delete(office_id)
    end_year -= 2
  end
end
puts "



"
puts "Random #{phase} sample:"
p Experience.where(user_id: 3)
puts "


"
# run - rake job_scraping - to seed jobs


# phase = "jobs"
# puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

# terminal_counter = 1

# jobs.each do |job|
#   office_ids = Office.pluck(:id)
#   office_id = office_ids.sample
#   Opening.create!(date: Faker::Time.forward(days: rand(10..40), period: :evening),
#                  job_position: job["job_position"],
#                  description: JOB_DESCRIPTIONS.sample,
#                  office_id: office_id)

#   puts "=== #{terminal_counter} out of #{n_jobs} #{phase} seeded ==="
#   terminal_counter += 1
# end
# puts ""
# puts "Random #{phase} sample:"
# p Opening.find(rand(1..Opening.all.count))
puts "


"
phase = "rating"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

n_ratings.times do
  office_ids = Office.pluck(:id)
  office_id = office_ids.sample
  Rating.create!(culture: rand(3..5),
                salary: rand(3..5),
                architecture: rand(3..5),
                office_id: office_id)

  puts "=== #{terminal_counter} out of #{n_ratings}s #{phase} seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p Rating.find(rand(1..Rating.all.count))
puts "



"
phase = "rsvp"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

ui = 1
n_rsvps.times do
events.each do |_|
  Rsvp.create(user_id: (ui+5),
              event_id: ui)
  Rsvp.create(user_id: ui,
              event_id: ui)
  Rsvp.create(user_id: (ui+2),
              event_id: ui)
  Rsvp.create(user_id: (ui+1),
              event_id: ui)
  ui += 1
end
  puts "=== #{terminal_counter} out of #{n_rsvps} #{phase}s seeded ==="
  terminal_counter += 1
end
puts "



"
puts "Random #{phase} sample:"
p Rsvp.find(rand(1..Rsvp.all.count))
puts "



"
phase = "comment"
puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

terminal_counter = 1

n_comments.times do
  # Post Comment
  Comment.create(post_id: rand(1..18),
                  user_id: rand(1..n_users),
                  date: Faker::Time.backward(days: rand(1..20), period: :evening),
                  content: COMMENTS.sample)

  # Office Comment
  Comment.create(office_id: rand(1..12),
                  user_id: rand(1..n_users),
                  date: Faker::Time.backward(days: rand(1..20), period: :morning),
                  content: COMMENTS.sample)

  # Event Comment
  Comment.create(event_id: rand(1..22),
                  user_id: rand(1..n_users),
                  date: Faker::Time.backward(days: rand(1..20), period: :evening),
                  content: COMMENTS.sample)

  puts "=== #{terminal_counter * 3} out of #{n_comments * 3} #{phase}s seeded ==="
  terminal_counter += 1
end
puts "


"
puts "Random #{phase} sample:"
p Comment.find(rand(1..Comment.all.count))
puts "


"
puts "Sumber of seeds created:
--Offices: #{Office.all.count}
--Team Member Accounts #{n_team_members}
--User Accounts #{(User.all.count - 4)}
--Posts: #{Post.all.count}
--Events: #{Event.all.count}
--Experiences: #{Experience.all.count}
--Jobs: #{Opening.all.count}
--Ratings: #{Rating.all.count}
--RSVPS: #{Rsvp.all.count}
--Comments: #{Comment.all.count}"

