class LikesController < ApplicationController
  
  def create
    like=current_user.active_like.new(micropost_id:params[:micropost_id])
    like.save
    @micropost=Micropost.find(params[:micropost_id])
    @micropost.create_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
end