class Opening < ApplicationRecord
  belongs_to :office

  validates :date, presence: true
  validates :job_position, presence: true 

end
