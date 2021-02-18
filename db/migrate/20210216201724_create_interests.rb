class CreateInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :interests do |t|
      t.string :user_id, null: false
      t.string :product_id, null: false
      t.integer :score, null: false

      t.index :product_id
      t.index [:user_id, :product_id], unique: true
    end
  end
end
