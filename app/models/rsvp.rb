class Rsvp < ApplicationRecord
  # associations
  belongs_to :event
  belongs_to :user
end
