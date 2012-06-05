class AddProductIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :product_id, :integer

  end
end
