class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name
      t.text :caption
      t.integer :price
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
