require 'csv'
require 'iconv'

class CsvImportController < ApplicationController
  def csv_import
  end
  
  def house_hold_summary
    Side.all.each {|r| r.destroy}
    @data = (params[:dump][:file]).read
    CSV.parse(@data) do |row|
      save_side(row[2]) if row[2] != nil
      save_household(row[0], row[2]) if row[0] != nil
    end
    import_guests(params[:dump][:guests].read)
    redirect_to('/csv_import', :notice => "Imported successfully") 
  end
  
  def import_guests(guests_file)
    Person.all.each {|r| r.destroy}
    CSV.parse(guests_file) do |row|
      save_guests(row)
    end
  end
  
  def save_side(side_name)
    side = Side.new
    side.name = Iconv.iconv('utf-8', 'iso8859-1', side_name).first
    side.save if Side.find_by_name(side_name) == nil
  end
  
  def save_household(household, side_name)
    puts household
    side = Side.find_by_name(side_name)
    name = Iconv.iconv('utf-8', 'iso8859-1', household).first
    side.households.create(:name => name)
  end
  
  def save_guests(people)
    guest = Person.new
    guest.first_name = Iconv.iconv('utf-8', 'iso8859-1', people[0]).first
    guest.lastname = Iconv.iconv('utf-8', 'iso8859-1', people[1]).first
    guest.household_id = find_household_id(Iconv.iconv('utf-8', 'iso8859-1', people[2]).first)
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
