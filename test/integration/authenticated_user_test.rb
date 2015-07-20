require "test_helper"

class UnauthenticatedUserTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = Apicurious::Application
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: 'twitter',
        extra: {
          raw_info: {
            user_id: "1234",
            name: "Max",
            screen_name: "maximus",
          }
        },
        credentials: {
          token: "burrito",
          secret: "secretburrito"
        }
      })
  end

  test 'the authenticated user is logged in' do
    visit root_path
    click_link "Login!"
    
    assert page.has_content?("Max")
    assert page.has_link?("Logout")
  end
end
