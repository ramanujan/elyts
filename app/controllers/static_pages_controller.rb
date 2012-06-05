class StaticPagesController < ApplicationController

  def home

  end
 
  def heroku_db_reset
    @output = `rake db:reset`
    @title="Heroku db reset" 
  end

  def heroku_db_migrate
    @output = `rake db:migrate`
    @title="Heroku db migrate" 
  end

end
