class Office < ApplicationRecord
    has_many :experiences
    has_many :users, through: :experiences

    has_many :ratings

    has_many :comments

    validates :name, presence: true, uniqueness: true
    validates :location, presence: true
    validates :url, presence: true, uniqueness: true
end
