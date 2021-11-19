class Office < ApplicationRecord
  # associations
  has_many :experiences
  has_many :openings, dependent: :destroy
  has_many :users, through: :experiences

  has_many :ratings
  has_many :office_projects
  has_many :comments, dependent: :nullify

  # validations
  validates_presence_of :name, :url, :location
  validates_uniqueness_of :name, :url

  # active storage
  has_one_attached :photo
  has_rich_text :description

  # named scope
  scope :starts_with, lambda { |character|
    where("LOWER(name) LIKE :prefix", prefix: "#{character.downcase}%")
  }
  scope :sorted, lambda { order(:name) }

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
