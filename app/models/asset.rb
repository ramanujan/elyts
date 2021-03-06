# == Schema Information
#
# Table name: assets
#
#  id                 :integer         not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  product_id         :integer
#

=begin
  
  Il metodo has_attached_file(:image) ha l'effetto di creare i seguenti attributi:
  
  0) image
  1) image_file_name
  2) image_file_size
  3) image_content_type
  4) image_updated_at  
  
  NELLA classe da cui viene invocato ( Asset in questo caso ). Come si vede sono gli attributi fisici relativi 
  alle colonne generate nella migrazione, e in più abbiamo l'attributo image e i suoi relativi accessors. 
  Ad image assegniamo params[:product][:image] e cioè l'istanza di IO che punta al file caricato sul server. 
  
  --STORAGE-----------------------------------------------------------------------------------------------------------------
  
  Dove vengono posti i file caricati? Vengono posti nelle apposite directory, che possiamo configurare 
  per mezzo dell'opzione :path. Questa per default è :
  
    :rails_root/public/system/:attachment/:id/:style/:filename
  
  Dove l'id è quello del record relativo alla classe che invoca has_attached_file (Asset nel nostro caso), e 
  style sono gli stili che abbiamo richiesto a paperclip per mezzo dell'Hash styles. 
   
  Come le piazziamo le nostre belle immagini? 
  
  Ad esempio:
  
  <%= image_tag @product.asset.image.url(:small) %>

  N.B. NON DIMENTICARE DI INVOCARE  
  
    t.has_attached_file :image
  
  Nella migrazione relativa alla creazione della tabella assets
  
=end

class Asset < ActiveRecord::Base
 
 belongs_to :product
 
 has_attached_file :image, 
                   :styles => { :large=>"640x480!",:medium => "300x200!", :thumb => "100x100!" },
                   :default_url => "/images/medium/missing.png"


  
 validates_attachment_size :image, :less_than => 10.megabytes  
 validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png','image/gif']

end
