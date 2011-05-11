class AddUserToSeries < ActiveRecord::Migration
  def self.up
    add_column :series, :user_id, :integer
  end

  def self.down
    remove_column :series, :user_id
  end
end
