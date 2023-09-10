class RemoveBodyFromRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :body, :text
  end
end
