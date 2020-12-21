class Post < ApplicationRecord
  # associations
  belongs_to :user
  has_many :comments, dependent: :nullify

  # validations
  validates :date, presence: true
  validates :title, presence: true
  validates :content, presence: true

  # active storage
  has_one_attached :photo

  # action text
  has_rich_text :content

  # tags
  acts_as_taggable_on :tags
end
