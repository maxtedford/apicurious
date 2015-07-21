class DashboardController < ApplicationController
  
  def index
    
  end
  
  def tweet
    current_user.twitter_client.update(params[:tweet])
  end
end
