class AddBirthdayToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :birthday, :date
  end
end
