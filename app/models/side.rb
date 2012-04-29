class Side < ActiveRecord::Base
  has_many :households, :dependent => :destroy
  
  validates_uniqueness_of :name
end
