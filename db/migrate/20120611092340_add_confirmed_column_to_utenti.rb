class AddConfirmedColumnToUtenti < ActiveRecord::Migration
  def change
    
    add_column :utenti, :confirmed, :boolean, default:false

  end
end
