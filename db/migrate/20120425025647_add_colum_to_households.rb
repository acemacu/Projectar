class AddColumToHouseholds < ActiveRecord::Migration
  def self.up
    add_column :households, :name, :strings
  end

  def self.down
    remove_column :households, :name
  end
end
