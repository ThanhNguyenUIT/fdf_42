class AddDefaultValueToActiveAttribute < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :active, :boolean, default: true
  end

  def down
    change_column :products, :active, :boolean, default: nil
  end
end
