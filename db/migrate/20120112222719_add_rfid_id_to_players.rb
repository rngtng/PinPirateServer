class AddRfidIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :rfid_id, :string
  end
end
