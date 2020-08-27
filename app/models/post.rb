class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :nullify

  validates :date, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
