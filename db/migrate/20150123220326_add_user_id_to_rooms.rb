class AddUserIdToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :user, index: true
    add_foreign_key :rooms, :users
  end
end
