class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :code
      t.string :url
      t.string :title
      t.string :short_description
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.decimal :old_price, precision: 10, scale: 2
      t.integer :rating_sum
      t.integer :ratings
      t.integer :stock
      t.integer :images_count
      t.boolean :hidden

      t.timestamps
    end
  end
end
