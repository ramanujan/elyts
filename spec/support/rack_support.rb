module RackSupport
  include Rack::Test::Methods

  def app
    Rails.application
  end

end


RSpec.configure do |c|
  c.include RackSupport, :type => :with_rack_methods
end
