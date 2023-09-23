class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :subject, polymorphic: true
      t.references :user, foreign_key: true, null: false
      t.integer :action_type, null: false
      t.boolean :checked, null: false, default: false
      t.integer :visitor_id
      t.integer :visited_id

      t.timestamps
    end
  end
end
