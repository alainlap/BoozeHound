class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :lcbo_id
      t.string :name
      t.integer :price_in_cents
      t.string :primary_category
      t.string :secondary_category
      t.string :origin
      t.integer :price_per_liter_of_alcohol_in_cents
      t.string :producer_name
      t.string :image_thumb_url
      t.string :image_url

      t.timestamps
    end
  end
end
