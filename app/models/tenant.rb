class Tenant < ApplicationRecord
  has_many :properties, dependent: :destroy

  # validations
  validates_presence_of :name, :email, :phone

  #callback

  before_create do
    self.availability = AvailableTime::TimeSlot.new(8.00,"8.00pm",:interval => 1.hour).free_slots if availability.empty?
  end

  #scope
  scope :by_name, -> { where(name: name) }
  scope :by_email, -> { where(email: email) }
  scope :by_phone, -> { where(phone: phone) }
end
