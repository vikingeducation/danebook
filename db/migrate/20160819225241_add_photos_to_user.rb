class AddPhotosToUser < ActiveRecord::Migration
  def change
    add_column :users, :cover_photo_id, :integer
    add_column :users, :profile_picture_id, :integer
  end
end
