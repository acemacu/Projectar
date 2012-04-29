require 'csv'

class CsvImportController < ApplicationController
  def csv_import
  end
  
  def house_hold_summary
    Side.all.each {|r| r.destroy}
    @parsed_file = CSV::Reader.parse(params[:dump][:file])
    @parsed_file.each do |row|
      save_side(row[2]) if row[2] != nil
      save_household(row[0], row[2]) if row[0] != nil
    end
    import_guests(params[:dump][:guests])
    redirect_to('/csv_import', :notice => "Imported successfully") 
  end
  
  def import_guests(guests_file)
    Person.all.each {|r| r.destroy}
    @parsed_file = CSV::Reader.parse(guests_file)
    @parsed_file.each do |row|
      save_guests(row)
    end
  end
  
  def save_side(side_name)
    side = Side.new
    side.name = side_name.to_s
    side.save if Side.find_by_name(side_name.to_s) == nil
  end
  
  def save_household(household, side_name)
    puts household
    side = Side.find_by_name(side_name.to_s)
    side.households.create(:name => household.to_s)
  end
  
  def save_guests(people)
    guest = Person.new
    guest.first_name = people[0]
    guest.lastname = people[1]
    guest.household_id = find_household_id(people[2])
    people[5] == "Yes" ? guest.child = true : guest.child = false
    guest.save if guest.household_id
  end
  
  def find_household_id(household_name)
    hs = Household.find_by_name(household_name)
    if hs
      return hs.id
    end
    return ""
  end
end
