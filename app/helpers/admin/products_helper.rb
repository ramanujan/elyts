module Admin::ProductsHelper
  
  def create_product_flash_message(action,type,flash_type=:normal) 
    result=case action 
      when 'find_error'
        message=t("admin.products.find_error")
        message
      when 'create_success'
        message=t("admin.products.create.success",:title=>@product.title);
        message+=" "+view_context.link_to( t("admin.products.create.where"),store_index_path ) 
        message+=t("admin.products.create.or")
        message+=view_context.link_to( t("admin.products.create.another") , new_admin_product_path ) 
        message
      when 'update_success'  
        message=t("admin.products.update.success",:title=>@product.title);
        message+=" "+view_context.link_to( t("admin.products.update.where"),'#' )
        message+=" "+t("admin.products.update.or")
        message+=" "+view_context.link_to( t("admin.products.update.continue"   ),admin_products_path)
        message 
      when 'delete_success'
        message=t("admin.products.delete.success",title:@product.title) 
      # ajax flash part
      when 'update_inventory_success'
         message=t("admin.products.inventory.success")      
      when 'update_inventory_invalid'
         message=t("admin.products.inventory.invalid")    
     end
     
     (flash_type==:normal) ? (flash[type.to_sym]=message.html_safe) : 
       (flash.now[type.to_sym]=message.html_safe)
  
   end

  
end
