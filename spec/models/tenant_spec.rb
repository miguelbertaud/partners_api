require 'rails_helper'

RSpec.describe Tenant, type: :model do
  it { should have_many(:properties) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }
end
