class CreateRecipeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_tags do |t|
      t.integer :recipe_id, null: false, foreign_key: true
      t.integer :tag_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :recipe_tags, [:recipe_id, :tag_id], unique: true
  end
end
