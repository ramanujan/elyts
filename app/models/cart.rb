# == Schema Information
#
# Table name: carts
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# Inizialmente ogni utente, anche un utente che non sia stato ancora autenticato ha 
# associata una sessione. Quando un utente sceglie un prodotto, ed esegue Add To Cart
# viene invocato current_cart(). Se la risorsa Cart non è stata ancora creata, allora
# viene creata (nel database) e il suo id viene messo nella sessione corrente.

# Ricorda che, a meno di non specificare in maniera diversa, la sessione scade allo shutdown del
# browser. L'autenticazione implementata da noi però è di tipo remember_me. Questo è da tener 
# presente quando assocerai il carrello della spesa all'utente. 

 


class Cart < ActiveRecord::Base
 has_many :line_items
 
end


