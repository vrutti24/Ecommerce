class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true, null: true # Allow null for guest carts
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
