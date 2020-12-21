class Opening < ApplicationRecord
  # associations
  belongs_to :office, optional: true

  # validations
  validates :date, presence: true
  validates :job_position, presence: true
  validates :job_url, uniqueness: true

  # rich text
  has_rich_text :description

  # smart methods
  def recent?
    date > 1.month.ago
  end
end
