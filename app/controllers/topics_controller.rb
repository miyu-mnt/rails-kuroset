class TopicsController < ApplicationController
  def index
    @topics = Topic.all.includes(:favorite_users).order(created_at: :desc)
  end
  
  def show
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def edit
    @topic = Topic.find_by(id: params[:id])
  end

  def update
    @topic = Topic.find_by(user_id: current_user.id, id: params[:id])
    if @topic.update(description_params)
      redirect_to topics_path, success: '投稿を編集しました'
    else
      flash.now[:danger] = '投稿の編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @topic = Topic.find_by(user_id: current_user.id, id: params[:id])
    @topic.destroy
    redirect_to topics_path, success: '投稿を削除しました'
  end
    
  private
    def topic_params
      params.require(:topic).permit(:image, :description)
    end
    
    def description_params
      params.require(:topic).permit(:description)
    end
end
