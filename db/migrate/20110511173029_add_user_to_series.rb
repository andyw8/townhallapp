class AddUserToSeries < ActiveRecord::Migration
  def self.up

    # some series created during early testing may not have a user associated,
    # so we'll just clear them out to avoid problems

    Series.delete_all

    add_column :series, :user_id, :integer
  end

  def self.down
    remove_column :series, :user_id
  end
end
