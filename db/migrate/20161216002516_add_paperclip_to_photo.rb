class AddPaperclipToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_attachment :photos, :picture
  end
end
