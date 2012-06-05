class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string   :title
      t.text     :description
      t.decimal  :price, precision:8, scale:2 # 8 cifre significative e 2 cifre dopo la virgola

      t.integer  :inventory, default:0 # valore di default 0
      t.timestamps
    end
  end
end
