class AddPasswordDigestToUtenti < ActiveRecord::Migration
  def change
    add_column :utenti, :password_digest, :string
  
  end
end
