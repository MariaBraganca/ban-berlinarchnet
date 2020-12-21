class Office < ApplicationRecord
  # associations
  has_many :experiences
  has_many :openings, dependent: :destroy
  has_many :users, through: :experiences

  has_many :ratings
  has_many :office_projects
  has_many :comments, dependent: :nullify

  # validations
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :url, presence: true, uniqueness: true

  # active storage
  has_one_attached :photo

  # action text
  has_rich_text :description

  # pgsearch
  include PgSearch::Model
  pg_search_scope :office_search,
    against: [ :name, :location ],
    using: {
      tsearch: { prefix: true }
  }

  # mapbox
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # smart methods
  def average_architecture_rating
    average = ratings.map{|rating| rating.architecture}
    (average.sum / average.length).to_i rescue 0
  end

  def average_culture_rating
    average = ratings.map{|rating| rating.culture}
    (average.sum / average.length).to_i rescue 0
  end

  def average_salary_rating
    average = ratings.map{|rating| rating.salary}
    (average.sum / average.length).to_i rescue 0
  end

  # def average_rating
  #   overall = [average_architecture_rating, average_culture_rating, average_salary_rating]
  #   (overall.sum / overall.length).to_i rescue 0
  # end
end
