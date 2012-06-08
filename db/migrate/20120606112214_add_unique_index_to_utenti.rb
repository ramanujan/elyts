class AddUniqueIndexToUtenti < ActiveRecord::Migration
  def change
     add_index :utenti, :email, unique: true
  end
end
