class AddAdminFieldToUtenti < ActiveRecord::Migration
  def change
    add_column :utenti, :admin, :boolean, default: false
  end
end
