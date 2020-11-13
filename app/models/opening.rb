class Opening < ApplicationRecord
  belongs_to :office, optional: true

  validates :date, presence: true
  validates :job_position, presence: true
  validates :job_url, uniqueness: true
end
