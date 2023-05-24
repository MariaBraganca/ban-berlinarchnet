require 'json'
require_relative 'seeds/seed_json.rb'

USERS = { type: 'Users', filepath: 'db/seeds/data/users.json', proc: lambda { |users| User.create!(users) } }

EVENTS = { type: 'Events', filepath: 'db/seeds/data/events.json', proc: lambda { |events| Event.create!(events) } }
OFFICES = { type: 'Offices', filepath: 'db/seeds/data/offices.json', proc: lambda { |offices| Office.create!(offices) } }
POSTS = { type: 'Posts', filepath: 'db/seeds/data/posts.json', proc: lambda { |posts| Post.create!(posts) } }

USER_EXPERIENCES = { type: 'User Experiences',
                     filepath: 'db/seeds/data/user_experiences.json',
                     proc: lambda { |user_experiences| Experience.create!(user_experiences) } }

USER_COMMENTS =    { type: 'User Comments',
                     filepath: 'db/seeds/data/user_comments.json',
                     proc: lambda { |user_comments| Comment.create!(user_comments) } }

OFFICE_PROJECTS =  { type: 'Office Projects',
                     filepath: 'db/seeds/data/office_projects.json',
                     proc: lambda { |office_projects| OfficeProject.create!(office_projects) } }

[
  USERS,
  EVENTS,
  OFFICES,
  POSTS,
  USER_EXPERIENCES,
  USER_COMMENTS,
  OFFICE_PROJECTS
].each do |seed|
  SeedJson.new(type: seed[:type], filepath: seed[:filepath]).call(&seed[:proc])
end

Rsvp.create!((1..Event.count).inject([]) { |array, n| array << { user_id: 1, event_id: n} })

# To do's:
  # Add office ratings
  # Add post tags
  # Add rake task for jobs
