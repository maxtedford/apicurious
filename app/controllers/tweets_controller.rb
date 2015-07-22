class TweetsController < ApplicationController
  
  def create
    current_user.post_tweet(params[:text])
    redirect_to dashboard_path
  end
end
