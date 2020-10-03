class UsersController < ApplicationController
  before_action:authenticate_user, only: [:index, :show, :edit, :update]
  before_action:forbid_login_user, only: [:new, :create]
  
  def index
    @users = User.all.order(name: :asc)
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end

  def favorites
    @user = User.find_by(id: params[:id])
    @favorite_topics = @user.favorite_topics
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.user_image = 'default.png'
    if @user.save
      redirect_to topics_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end
  
  def edit
  end
  
  def update
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end