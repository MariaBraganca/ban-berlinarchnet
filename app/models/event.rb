# TODO's:
#
# Photos:
# development :local
# resize images for web usage, card 1/4 viewport width
# review images (midjourney?)
# production: add s3 for storage
#
# Front End:
# make cards bigger on hover
# change icon for online events
#
# Backend:
# change event policy
# add anchor pagination, on date
# load on scroll

class Event < ApplicationRecord
  BERLIN_TZ = 'Berlin'
  MEETUP_URL = "https://www.meetup.com/ban-berlin-architectural-network/events/".freeze

  # validations
  validates_presence_of :date, :title, :location, :meetup_id

  # named scopes
  scope :next, lambda { where("date > ?", Time.now) }
  scope :past, lambda { where("date < ?", Time.now) }
  scope :sorted, lambda { order(date: :desc) }

  # active storage
  has_one_attached :photo do |attachable|
    attachable.variant :card,
      resize_to_limit: [250, 250],
      format: :jpeg,
      saver: { subsample_mode: "on", strip: true, interlace: true, quality: 80 }
  end

  # smart methods
  def next?
    date > Time.now
  end

  def formatted_date
    date.in_time_zone(BERLIN_TZ).strftime('%d.%b %Y')
  end

  def meetup_url
    MEETUP_URL + meetup_id
  end
end
