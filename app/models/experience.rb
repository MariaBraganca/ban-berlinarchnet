class Experience < ApplicationRecord
  belongs_to :office
  belongs_to :user

  validates :start_date, presence: true
  validates :job_position, presence: true
end
