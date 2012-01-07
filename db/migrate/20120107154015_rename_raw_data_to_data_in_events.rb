class RenameRawDataToDataInEvents < ActiveRecord::Migration
  def up
    Event.all.map do |event|
       data = YAML::load(event.raw_data).map do |d|
         "%02x" % d.hex
       end.join
       Event.update_all({:raw_data => data}, :id => event.id)
    end

    rename_column :events, :raw_data, :data
    change_column :events, :data, :string, :null => false
  end

  def down
    Event.all.map do |event|
      Event.update_all({:data => event.data.to_s.scan(/../).to_yaml}, :id => event.id)
    end

    rename_column :events, :data, :raw_data
  end
end
