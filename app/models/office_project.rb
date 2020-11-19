class OfficeProject < ApplicationRecord
  belongs_to :office
  has_one_attached :photo

  validates :project_name, presence: true
end
