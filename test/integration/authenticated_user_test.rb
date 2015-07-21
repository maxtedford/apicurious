require "test_helper"

class UnauthenticatedUserTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = Apicurious::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: 'twitter',
        extra: {
          raw_info: {
            user_id: "1234",
            name: "Max Tedford",
            screen_name: "Max_Tedford",
          }
        },
        credentials: {
          token: "240955419-I69HOrP1erL7yhyFgs5exUK2JHP14bQKvWpdhPmZ",
          secret: "YESsUryQw50W61XwKHtTAxXLgdR00p6uNBvdijnN1jlh4"
        }
      })
  end

  test 'the authenticated user is logged in' do
    visit root_path
    click_link "Login!"
    
    assert_equal dashboard_path, current_path
    assert page.has_content?("Max Tedford")
    
    visit root_path
    
    assert page.has_link?("Logout"), "Can't see the logout link"
  end
  
  test 'the authenticated user sees their name' do
    visit root_path
    click_link "Login!"
    
    assert page.has_content?("Max Tedford"), "Name ain't there..."
  end
  
  test 'the authenticated user sees their screen name' do
    visit root_path
    click_link "Login!"
    
    assert page.has_content?("maximus"), "Screen name ain't there..."
  end
end
