class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def show
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      send_welcome_email
      permanent_sign_in(@user)
      flash[:success] = "User created successfully"
      redirect_to root_path
    else
      @user.build_profile
      flash.now[:danger] = "Failed to create user"
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Profile updated successfully"
      redirect_to user_path(current_user.id)
    else
      flash.now[:danger] = "Failed to update profile"
      render :edit
    end
  end

  def search
    @search_param = params[:search]
    @users = User.search(params[:search])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
      :profile_attributes =>
      [:id, :first_name, :last_name, :birthday, :gender, :college, :hometown,
       :currently_lives, :telephone, :words, :about]
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def send_welcome_email
    UserMailer.welcome(@user.id).deliver_later
  end

  def send_suggest_friends_email
    UserMailer.delay(run_at: 5.minutes.from.now).suggest_friends(@user.id)
  end

end
