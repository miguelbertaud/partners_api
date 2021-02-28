class Tenant < ApplicationRecord
  has_many :properties, dependent: :destroy

  # validations
  validates_presence_of :name, :email, :phone

  #scope
  scope :by_name, -> { where(name: name) }
  scope :by_email, -> { where(email: email) }
  scope :by_phone, -> { where(phone: phone) }
end
