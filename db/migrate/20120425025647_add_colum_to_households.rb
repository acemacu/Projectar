class AddColumToHouseholds < ActiveRecord::Migration
  def self.up
    add_column :households, :name, :string
  end

  def self.down
    remove_column :households, :name
  end
end
