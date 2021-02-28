class Tenant < ApplicationRecord
  has_many :properties, dependent: :destroy

  # validations
  validates_presence_of :name, :email, :phone
end
