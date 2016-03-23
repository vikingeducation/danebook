class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :photo
      t.integer :user_id

      t.index :user_id
      
      t.timestamps null: false
    end
  end
end
