Given(/^there is a product named "([^"]*)"$/) do |title|
 @product = FactoryGirl.create(:product, title:title)
end