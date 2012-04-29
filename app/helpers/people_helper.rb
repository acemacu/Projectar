module PeopleHelper
  def find_household_name(household_id)
    hs = Household.find(household_id)
    hs.name
  end
  
  def find_side(household_id)
     hs = Household.find(household_id)
     side = Side.find(hs.side_id)
     side.name
  end
  
end
