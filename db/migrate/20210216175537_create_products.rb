class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table(:products, id: :string) do |t|
      t.string :name, null: false
      t.string :category, null: false
    end
  end
end
