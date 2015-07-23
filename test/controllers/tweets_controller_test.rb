require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  
  test "successfully posts a tweet with prod data" do
    user = User.create(name: "Max Tedford",
                       screen_name: "Max_Tedford",
                       uid: "1234",
                       oauth_token: ENV["SAMPLE_OAUTH_TOKEN"],
                       oauth_token_secret: ENV["SAMPLE_OAUTH_TOKEN_SECRET"])
    session[:user_id] = user.id

    VCR.use_cassette("max_tweets") do
      post :create, :text => "tweeting from an api call"
      assert_response 302
    end
  end
  
  def tweet_data
    JSON.parse(File.read(File.join(Rails.root, "test", "fixtures", "tweets_response.json"))).map do |hash|
      Hashie::Mash.new(hash)
    end
  end
end
