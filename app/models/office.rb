class Office < ApplicationRecord
  
  include PgSearch::Model
  pg_search_scope :office_search, 
    against: [ :name, :location ],
    using: {
      tsearch: { prefix: true }
  }

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many :experiences
  has_many :users, through: :experiences

  has_many :ratings
  has_many :office_projects
  # scope :ordered, -> { includes(:ratings).order('ratings.salary desc') }
  # scope :ordered, -> { includes(:ratings).order(Rating.arel_table[:culture].desc) }

  has_many :comments, dependent: :nullify
  has_one_attached :photo
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :url, presence: true, uniqueness: true



end
