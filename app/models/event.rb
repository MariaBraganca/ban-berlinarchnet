class Event < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  belongs_to :user

  has_many :rsvps
  has_many :users, through: :rsvps

  has_many :comments

  validates :date_time, presence: true
  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
