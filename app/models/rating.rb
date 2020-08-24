class Rating < ApplicationRecord
    has_many :office_ratings
    has_many :offices, through: :office_ratings
end
