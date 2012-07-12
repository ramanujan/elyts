module ApplicationHelper
  
  BASE_TITLE = I18n.t("base_title") 
  
  def title
  
    @title ? (BASE_TITLE+"|"+@title) : BASE_TITLE  
  
  end
  
  
  
  def brief message,type=nil
  
    if type.nil?
      message.length >= 180 ? (message[0..179]+"...") : message
    else
      message.length >= 30 ? (message[0..29]+"...") : message
    end
  
  end 

  
  # try() è un metodo aggiunto da Rails come Monkey Patch ad ogni nostro componente.
  # Il comportamento di try() è quello di provare un metodo sull'oggetto. Se il metodo
  # non esiste, oppure se current_user non esiste ritorna nil 
  
  def admins_only(&block)
    block.call if current_user.try(:is_admin?)
  end

  
  
end
