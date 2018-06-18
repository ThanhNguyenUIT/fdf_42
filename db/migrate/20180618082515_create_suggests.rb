class CreateSuggests < ActiveRecord::Migration[5.2]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true
      t.string :product_name
      t.text :content
      t.timestamps
    end
  end
end
