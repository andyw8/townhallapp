class AddScoreToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :score, :integer, default: 0
  end

  def self.down
    remove_column :submissions, :score
  end
end
