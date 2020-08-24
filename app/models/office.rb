class Office < ApplicationRecord
    has_many :experiences
    has_many :users, through: :experiences

    has_many :office_ratings
    has_many :ratings, through: :office_ratings

    has_many :comments
end
