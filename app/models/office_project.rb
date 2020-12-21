class OfficeProject < ApplicationRecord
  # associations
  belongs_to :office

  # validations
  validates :project_name, presence: true

  # active storage
  has_one_attached :photo
end
