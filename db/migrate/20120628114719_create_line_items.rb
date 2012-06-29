class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t| 
      t.timestamps
      t.references :product
      t.references :cart
    end
  end
end
