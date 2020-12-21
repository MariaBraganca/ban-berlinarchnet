class Experience < ApplicationRecord
  # associations
  belongs_to :office
  belongs_to :user

  # validations
  validates :start_date, presence: true
  validates :job_position, presence: true

  # smart methods
  def current?
    !end_date
  end
end
