class Spree::CreditLine < ActiveRecord::Base
  
   has_one :customer, class_name: "Spree::User"
  
end