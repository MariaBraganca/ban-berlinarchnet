class Experience < ApplicationRecord
  # associations
  belongs_to :office
  belongs_to :user

  # validations
  validates_presence_of :start_date, :job_position

  # smart methods
  def current?
    !end_date
  end
end
