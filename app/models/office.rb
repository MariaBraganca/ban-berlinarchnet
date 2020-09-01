class Office < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many :experiences
  has_many :users, through: :experiences

  has_many :ratings
  has_many :office_projects

  has_many :comments, dependent: :nullify
  has_one_attached :photo
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :url, presence: true, uniqueness: true
end
