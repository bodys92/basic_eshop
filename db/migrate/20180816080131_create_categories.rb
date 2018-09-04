class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :url
      t.string :title
      t.integer :order_no
      t.boolean :hidden, default: true
      t.references :category, foreign_key: true, default: nil

      t.timestamps
    end
  end
end
