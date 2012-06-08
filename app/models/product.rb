# == Schema Information
#
# Table name: products
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  price       :decimal(8, 2)
#  inventory   :integer         default(0)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Product < ActiveRecord::Base
  
  has_many :assets
  validates :title, presence:true
  validates :description, presence:true
  validates :price, presence:true,numericality:{greater_than_or_equal_to:0.01} 
  validates :inventory, presence:true,numericality:{greater_than_or_equal_to:0} 
  accepts_nested_attributes_for :assets
   
end


=begin
 
   Qui sopra abbiamo utilizzato un metodo speciale di ActiveRecord, e cioè 
     
     accepts_nested_attributes_for :assets 
   
   Questo fa si che AR crei un metodo d'istanza nella classe Product, 
   assets_attributes con i relativi accessors, assets_attributes() e
   assets_attributes=(), CHE PUÒ RICEVERE UN ARRAY DI HASH, OPPURE 
   UN HASH DI HASH, CONTENENTE I VALORI PER ISTANZIARE GLI OGGETTI
   Asset DELLA COLLEZIONE assets. Ma procediamo con ordine e andiamo
   ad analizzare tutto quello che succede quando clicchiamo su
   'Add product image'. Questo evento viene catturato dal seguente snippet: 
   
    $(->
      $('a#add_another_image').click(->
      url = "/files/new?number="+$('#images input').length
      $.get(url,(data)->  
        $('#images').append(data)
          ,"html")
   )
  )
  
  Come si vede viene eseguita una get asincorna all'azione puntata dall'url
  /files/new passando con la query string il numero di input fields sotto 
  l'elemento con id #images. Ecco l'azione: 
  
     def new
     
       @product = Product.new 
       @product.assets.build
       number=params[:number].to_i unless params[:number].nil?
       render :partial=>'files/form', :locals=>{:number=>number}
     
     end
   
   
   Come si nota l'azione esegue il rendering di un frammento di html.
   Questo è un primo modo di utilizzare AJAX. Il frammento è :
   
     <%=fields_for @product do |f| %>
       <%= f.fields_for :assets, :child_index=>number do |builder| %>
         <div>
           <%=builder.file_field :image %>
         </div>
       <%end%>
    <%end%>
   
   che produrrà il frammento: 
   
     <input id="product_assets_attributes_0_image" type="file" name="product[assets_attributes][0][image]">
   
   Se lo clicchiamo un'altra volta, verrà prodotto: 
   
     <input id="product_assets_attributes_1_image" type="file" name="product[assets_attributes][1][image]">
   
   Da cui si vede anche a cosa serve passare :child_index => number 
   
   Quando dunque impegnamo la form, cosa arriva al controllore products? La variabile params conterrà 
   qualcosa del genere: 
   
        params = {"utf8"=>"✓", 
                  "authenticity_token"=>"PnoRxQq5634WnBjL4FDN6PkKrglEArDFHy/xuWp4C6U=", 
                  
                  "product"=>{"title"=>"....", 
                              "description=>"bla, bla....",
                              .
                              .
                              "assets_attributes"=>{"0"=>{"image"=>"..rails prepara in modo che punti a istanza IO sul server"}, 
                                                    "1"=>{"image"=>""}, 
                                                    "2"=>{"image"=>""}
                                                  }
                          }, 
               
                "commit"=>"Create Product"
                }
          
   
   come si vede params[:product][:assets_attributes] è un hash di hash con cui è possibile
   popolare le istanze di Asset della classe Product ! 
   
   
   
     
=end
