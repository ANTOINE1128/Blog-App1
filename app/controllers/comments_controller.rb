class CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    post = @comment.post
    user = post.author
    @comment.destroy
    redirect_to user_post_path(user, post), notice: 'Comment was successfully deleted.'
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.author_id = current_user.id

    if comment.save
      render json: { notice: 'Comment successfully created', comment: }, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
