# BAN - Berlin Architectural Network

Berlin Architectural Network is a Ruby on Rails Application built for the homonymous Meetup group, which I've created in 2017. Since then, it has attracted hundreds of architecture lovers who come together to support each other through collaboration and networked learning.

Together with my team from the Bootcamp at Le Wagon, we've built this web application from scratch with Ruby, HTML, CSS and JavaScript.

Building a social platform as the final project in only 2 week's time, required a good understanding of database architecture, overall enjoyable user experience as well as skills on time and product management.

## Team
Maria Braganca (Product Owner)
Hristian Bozinoski
Ekaterina Tugarinova
Zeljka Vujic

## Web Stack
Github
Ruby on Rails
PostgreSQL
Heroku

## Libraries
Devise (authentication)
Pundit (authorization)
Cloudinary
Geocoding with Mapbox
PG Search
Bootstrap
AJAX in Rails
Websocket and Action Cable

## Goal and Process
The purpose of this project is to support architects, who are new to Berlin, on getting into the city's architecture scene and give the Meetup group an online presence.

The design process had 3 major phases:

### Phase 1 - Sign up
After defining each step of the user journey along with a Figma prototype, we designed the database schema and built the corresponding models on Rails. At this point we introduced Devise for authentication and Pundit for authorization, so that the user could sign up and become a member of the community.

### Phase 2 - Browse
In the second phase the user should be able to visit an office's page and check out a member's activity. For the database seeding, we used JSON due to its lightweight format. We also worked with services such as Cloudinary to host and upload images and Mapbox to display the location of the offices.

### Phase 3 - Interact
The last phase enabled the user to RSVP to an event, review it and chat with a member. AJAX allowed new content, such as comments and rsvps, to be displayed without reloading the page. For the chat, we've built a bidirectional Websocket connection combined with Action Cable for real-time messaging.

Visit my [Profile Page](https://mariabraganca.github.io/profile/pr_berlinarchnet.html) for more information.

## Live Preview
👉 [BAN - Berlin Architectural Network](https://berlinarchnet.herokuapp.com/)

## Screenshot
![Gif BAN](https://res.cloudinary.com/db5jh0zwo/image/upload/v1602153509/profile/ban-cover.jpg)
