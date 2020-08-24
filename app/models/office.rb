class Office < ApplicationRecord
    has_many :experiences
    has_many :users, through: :experiences

    has_many :ratings

    has_many :comments
end
