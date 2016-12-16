class AddLikesCountToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :likes_count, :integer,
                       :default => 0, :null => false
  end
end
