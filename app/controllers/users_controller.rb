class UsersController < ApplicationController
  before_action:authenticate_user, only: [:index, :show, :edit, :update]
  before_action:forbid_login_user, only: [:new, :create]
  before_action:ensure_correct_user, only: [:edit, :update]
  
  def ensure_correct_user
    if params[:id].to_i != @current_user.id
      redirect_to topics_path, success: '権限がありません'
    end
  end
  
  def index
    @users = User.all.order(name: :asc)
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @topics = @user.topics.order(created_at: :desc)
  end

  def favorites
    @user = User.find_by(id: params[:user_id])
    @favorite_topics = @user.favorite_topics.order(created_at: :desc)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.user_image = 'default.png'
    if @user.save
      session[:user_id] = @user.id
      redirect_to topics_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end
  
  def edit
    @user = User.find_by(params[:id])
  end
  
  def update
    @user = User.find_by(params[:id])
      if @user.update(user_params)
        redirect_to user_path, success: 'プロフィールを変更しました'
      else
        flash.now[:danger] = 'プロフィール変更に失敗しました'
        render :edit
      end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :user_image, :password, :password_confirmation)
  end
end