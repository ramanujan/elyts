class AddSaltToUtenti < ActiveRecord::Migration
  def change
    add_column :utenti, :salt, :string

  end
end
