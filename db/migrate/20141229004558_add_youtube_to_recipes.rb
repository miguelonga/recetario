class AddYoutubeToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :youtube, :string
  end
end
