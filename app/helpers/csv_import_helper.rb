module CsvImportHelper
  
  def get_household_side(household)
    side = Side.find_by_id(household.side_id)
    side.name
  end
end
