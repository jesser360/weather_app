class Weather < ApplicationRecord

  validates :zipcode, presence: true,
length: { minimum: 5, maximum: 5 }
end
