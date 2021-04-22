class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :product_name, null: false
      t.text :explanation, null: false
      t.integer :category_id             
      t.integer :status_id
      t.integer :delivery_fee_id
      t.integer :area_id
      t.integer :ship_id
      t.integer :price
      t.references :user, foreign_key: true   

      t.timestamps
    end
  end
end
