module StoreHelper
 
 PRODUCTS_PER_ROW = 3;
   
  # L'idea è di realizzare un iteratore che iteri su di una struttura più comoda
  # da utilizzare nel template relativo all'azione index del controller StoreController. 
  
  # In pratica l'iteratore fa esattamente quello che deve fare un iteratore. Fornisce
  # un meccanismo, un modo, una certa interfaccia, con cui il codice sterno può accedere ad
  # una collezione (container) di oggetti. Il container costruito dal costruttore sarà qualcosa del 
  # genere: 
  
  # { row_1=>[product1,product2,product3], 
  #   row_2=>[product4,product5,product6]
  #   .
  #   .
  # }
  #
  # L'iterazione avviene poi su row_1, .. row_n 
 
  
  class ProductsIterator
    
    def initialize(products)
    
      @container={};
      @index='row_0'; 
      build(products)
    
    end  
    
    def grouped_products
      @container
    end
    
    def total_rows_number(products) 
      products.length/PRODUCTS_PER_ROW
    end
    
     def number_of_products_in_the_last_row(products) 
       products.length % QUANTITY_PER_ROW      
     end   
     
     def product
       @container[@index]
     end 
     
    
     
     def next
       
       index = @index.split('_')[1].to_i  
       value=@container[@index] 
       index+=1;
       @index="row_#{index}"
       value
     
     end
     
     def has_next?
       
       @container.has_key? @index 
     
     end
     
     
      
     private

     def build(products)
       i=0;
       index=0
       
       total_rows_number(products).times do 
        
         @container["row_#{index}"]=[]   
        
         PRODUCTS_PER_ROW.times do 
           @container["row_#{index}"] << products[i]  
           i+=1
         end
        
        index+=1 
       
       end  
       
       
       @container["row_#{index}"]=[]
        
       self.number_of_products_in_the_last_row(products).times do |volte|
         @container["row_#{index}"] << products[i] 
         i+=1 
       end   
     
     end 
      
  end

end
