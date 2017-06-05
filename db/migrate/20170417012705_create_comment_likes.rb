class CreateCommentLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_likes do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true
      t.index [:user_id, :comment_id], unique: true
      t.timestamps
    end
  end
end
