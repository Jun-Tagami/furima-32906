class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text :product_name, null: false
      t.text :explanation, null: false
      t.integer :category             
      t.integer :status
      t.integer :deliverly_fee
      t.integer :area
      t.integer :ship
      t.integer :price
      t.references :user, foreign_key: true   

      t.timestamps
    end
  end
end
