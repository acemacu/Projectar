class AddColumToHouseholdn < ActiveRecord::Migration
  def self.up
    add_column :households, :side_id, :integer
  end

  def self.down
    remove_column :households, :side_id
  end
end
