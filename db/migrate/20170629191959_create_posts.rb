class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :body
      t.integer :user_id

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
