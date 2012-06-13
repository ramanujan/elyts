class AddRememberTokenToUtenti < ActiveRecord::Migration
  def change
    add_column :utenti, :remember_token, :string
    add_index :utenti, :remember_token, unique:true
  end
end
