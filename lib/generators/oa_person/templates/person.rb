class Person < ActiveRecord::Base
  include OaPerson::Models::Base
  
  attr_accessible :name
end
