class AddAvailabilityToTenants < ActiveRecord::Migration[6.1]
  def change
    add_column :tenants, :availability, :string, array:true, default: []
  end
end
