class RemoveTitleFromPhotos < ActiveRecord::Migration[5.2]
  def change
    remove_column :photos, :title, :text
  end
end
