class Property < ApplicationRecord
  belongs_to :tenant

  # validation
  validates_presence_of :name, :description, :rental_price, :status
end
