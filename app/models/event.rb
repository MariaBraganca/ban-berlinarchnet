class Event < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  belongs_to :user
  has_many :rsvps, dependent: :destroy
  has_many :users, through: :rsvps
  has_many :comments, dependent: :nullify
  has_one_attached :cover_photo
  has_many_attached :event_photos

  has_rich_text :description

  $format = ["··ban networking", "-·ban talks", "<·ban walks", "×·ban workshop"]
  
  validates :date, presence: true
  validates :format, inclusion: { in: $format }
  validates :title, presence: true
  validates :location, presence: true, unless: :online
  validates :online, presence: true, unless: :location
  validates :description, presence: true
end
