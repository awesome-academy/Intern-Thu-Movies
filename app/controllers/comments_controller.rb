class CommentsController < ApplicationController
  before_action :load_commentable
  before_action :find_comment, only: :destroy

  def create
    @comment = @commentable
               .comments
               .build comment_params.merge user_id: current_user.id
    if @comment.save
      respond_to :js
    else
      flash[:danger] = t ".error"
      redirect_to root_path
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = t ".cmt_success"
      respond_to :js
    else
      flash[:danger] = t ".error"
      redirect_to root_path
    end
  end

  private

  def load_commentable
    resource, id = request.path.split("/")[Settings.comment, Settings.comment]
    @commentable = resource.singularize.classify.constantize.find_by id: id
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
