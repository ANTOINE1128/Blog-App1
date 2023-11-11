class Api::V1::PostsController < ActionController::API
   skip_before_action :verify_authenticity_token
  def index
    @posts = User.find(params[:user_id]).posts
    render json: @posts
  end
end
