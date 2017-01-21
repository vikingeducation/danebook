class AddAttributesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :college, :string
    add_column :users, :hometown, :string
    add_column :users, :current_town, :string
    add_column :users, :phone, :string
    add_column :users, :words_to_live_by, :text
    add_column :users, :about_me, :text
  end
end
