class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :price, precision: 12, scale: 3
      t.string :receiver
      t.string :address
      t.string :phone
      t.references :user, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
