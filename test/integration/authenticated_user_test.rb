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
          token: ENV["SAMPLE_OAUTH_TOKEN"],
          secret: ENV["SAMPLE_OAUTH_TOKEN_SECRET"]
        }
      })
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Login!"
    assert_equal "/", current_path
    assert page.has_content?("Max Tedford")
    assert page.has_link?("Favorite! (0)")
    assert page.has_css?("p.TweetTextSize  js-tweet-text tweet-text")
  end
end
