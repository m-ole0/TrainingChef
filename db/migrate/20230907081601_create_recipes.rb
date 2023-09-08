class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.string :title, null: false
      t.text :material, null: false
      t.text :body, null: false
      t.text :process, null: false

      t.timestamps
    end
  end
end
