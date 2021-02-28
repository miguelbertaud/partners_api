require 'rails_helper'

RSpec.describe Property, type: :model do
  it { should belong_to(:tenant) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:rental_price) }
  it { should validate_presence_of(:status) }
end
