class Event < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  belongs_to :user
  has_many :rsvps
  has_many :users, through: :rsvps
  has_many :comments

  has_one_attached :cover_photo
  has_many_attached :event_photos

  validates :date, presence: true
  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
