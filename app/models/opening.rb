class Opening < ApplicationRecord
  # associations
  belongs_to :office, optional: true

  # validations
  validates_presence_of :date, :job_position
  validates_uniqueness_of :job_url


  # rich text
  has_rich_text :description

  # named scopes
  scope :recent, lambda { where("date > ?", 1.month.ago) }
  scope :old, lambda { where("date < ?", 1.month.ago) }
  scope :sorted, lambda { order(date: :desc) }

  # smart methods
  def recent?
    date > 1.month.ago
  end
end
