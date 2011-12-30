class AddTwitterHandleToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :twitter_handle, :string
  end
end
