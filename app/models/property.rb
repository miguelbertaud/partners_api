class Property < ApplicationRecord
  belongs_to :tenant

  #enum
  enum status: %i[published available deleted], _default: "available"

  # validation
  validates_presence_of :name, :description, :rental_price, :status

  #scope
  scope :by_name, -> { where(name: name) }
  scope :by_status, -> { where(status: status) }
  scope :by_price, -> { where(rental_price: price) }
end
