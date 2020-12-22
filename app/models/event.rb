class Event < ApplicationRecord
  # associations
  belongs_to :user
  has_many :rsvps, dependent: :destroy
  has_many :users, through: :rsvps
  has_many :comments, dependent: :nullify

  # collection
  $format = ["··bannetworking", "-·bantalks", "<·banwalks", "×·banworkshop"]

  # validations
  validates :start_date, presence: true
  validates :location, presence: true, unless: :online
  validates :title, presence: true
  validates :description, presence: true
  validates :format, presence: true
  validates :format, inclusion: { in: $format }
  validates :online, presence: true, unless: :location
  validates :online_link, presence: true, if: :online

  # named scopes
  scope :next, lambda { where("start_date > ?", Time.now) }
  scope :past, lambda { where("start_date < ?", Time.now) }
  scope :sorted, lambda { order(start_date: :desc) }
  scope :by_format, lambda { |format|
    where("LOWER(format) LIKE :suffix", suffix: "%#{format.downcase}")
  }
  scope :by_user, lambda { |user_id|
    where("user_id = ?", user_id)
  }

  # active storage
  has_one_attached :cover_photo
  has_many_attached :event_photos

  # action text
  has_rich_text :description

  # mapbox
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # smart methods
  def next?
    start_date > Time.now
  end
end
