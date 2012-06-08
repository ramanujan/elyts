# == Schema Information
#
# Table name: assets
#
#  id                 :integer         not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  product_id         :integer
#

require 'spec_helper'

describe Asset do
  pending "add some examples to (or delete) #{__FILE__}"
end
