class CommentsController < ApplicationController
  def create
    @topic = Topic.find_by(id: params[:topic_id])
    @comment = @topic.comments.new(comment_params)
    @comment.user_id = current_user.id
      if @commnet.save
        redirect_to topics_path, success: '投稿にコメントしました'
      else
        redirect_to topics_path, danger: '投稿へのコメントに失敗しました'
      end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to topics_path, success: 'コメントを削除しました'
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :topic_id, :user_id)
    end
end
