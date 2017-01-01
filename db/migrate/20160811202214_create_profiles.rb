class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.string :about
      t.references :user

      t.timestamps null: false
    end
  end
end
