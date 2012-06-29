# == Schema Information
#
# Table name: line_items
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  product_id :integer
#  cart_id    :integer
#

class LineItem < ActiveRecord::Base
  
  belongs_to :cart
  belongs_to :product
  
end



