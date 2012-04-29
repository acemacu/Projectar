class Household < ActiveRecord::Base
  belongs_to :side
  has_many :persons
end
