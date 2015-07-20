require "test_helper"

class UnauthenticatedUserTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = Apicurious::Application
  end
  
  test 'the unauthenticated user lands on the login page' do
    visit root_path
    
    assert page.has_link? "Login!"
  end
end
