class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :lastname
      t.boolean :child
      t.boolean :have_rspv
      t.boolean :rspv

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
