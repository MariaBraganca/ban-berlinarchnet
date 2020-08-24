class Event < ApplicationRecord
  belongs_to :user
  
  has_many :rsvps
  has_many :users, through: :rsvps

  has_many :comments
end
