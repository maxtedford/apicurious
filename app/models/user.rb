class User < ActiveRecord::Base
  
  def self.from_omniauth(auth_info)
    if user = find_by(uid: auth_info.extra.raw_info.user_id)
      user
    else
      create({name: auth_info.extra.raw_info.name,
              screen_name: auth_info.extra.raw_info.screen_name,
              uid: auth_info.extra.raw_info.user_id,
              oauth_token: auth_info.credentials.token,
              oauth_token_secret: auth_info.credentials.secret
        })
    end
  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = self.oauth_token
      config.access_token_secret = self.oauth_token_secret
    end
  end

  def twitter_timeline
    twitter_client.home_timeline
  end
  
  def current_profile
    twitter_client.user
  end
end
