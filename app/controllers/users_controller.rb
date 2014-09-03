class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :followers, :following]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user , only: :destroy

  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      UserMailer.welcome_email(@user).deliver
       flash[:notice] = 'User was successfully created.'
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id]) 
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private 
  def user_params
    params.require(:user).permit(:name,:email, :password, :password_confirmation)
  end

	
   def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


  def admin_user
    redirect_to(root_url) unless current_user.admin?
    end
end
