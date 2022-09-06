class AddFileToUser < ActiveRecord::Migration[6.0]
  def change
    add_attachment :users, :file
  end
end
