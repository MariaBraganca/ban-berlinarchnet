class Opening < ApplicationRecord
  belongs_to :office, optional: true

  has_rich_text :description

  validates :date, presence: true
  validates :job_position, presence: true
  validates :job_url, uniqueness: true
end
