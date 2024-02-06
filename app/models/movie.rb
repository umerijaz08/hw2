class Movie < ApplicationRecord
    belongs_to :studio
    has_many :casts
    has_many :actors, through: :casts
end
