class OfficeProject < ApplicationRecord
  # associations
  belongs_to :office

  # validations
  validates_presence_of :project_name

  # active storage
  has_one_attached :photo
end
