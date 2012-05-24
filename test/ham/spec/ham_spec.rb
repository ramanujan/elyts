require 'ham'

=begin
 
 un blocco subject permette di creare un'istanza a cui ci riferiremo in tutti gli esempi dentro il blocco 
 describe. Per riferirci a tale istanza, possiamo utilizzare il metodo its, oppure la variabile subject.
 A me il metodo its non funziona, quindi uso subject.  

=end

describe Ham do
  
  subject { Ham.new }
  
  it "should be edible" do
    subject.edible?.should  be_true
  end
  
  it "should be expired" do
    subject.expired!
    subject.should be_expired
    subject.should_not be_edible
  end

   
end