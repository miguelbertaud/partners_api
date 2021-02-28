class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.decimal :rental_price, precision: 8, scale: 2
      t.integer :status
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
