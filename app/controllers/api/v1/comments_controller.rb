class Api::V1::CommentsController < Api::V1::ApplicationController
    def index
        @comments = Comment.where(post_id: params[:post_id])
        render json: @comments, status: :ok
    end
end
