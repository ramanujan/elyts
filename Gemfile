source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.6'
gem "heroku"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem "paperclip", "2.7.0" # :git => "git://github.com/thoughtbot/paperclip.git"
gem 'bcrypt-ruby', '3.0.1'
gem 'nokogiri'
gem 'premailer-rails3' # Questa gem sposta lo styling dal tag <style> e lo rende inline 

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end



group :test,:development do
  gem 'sqlite3'
  gem 'rspec-rails','2.9.0'
  gem 'execjs'
  gem 'annotate', '~> 2.4.1.beta'
  
end

group :test do
  gem 'spork' 
  gem 'cucumber-rails', require:false;
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem "launchy"
end

group :production do
  gem 'pg'
  gem 'thin'
end
