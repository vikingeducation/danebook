class UsersController < ApplicationController

  #before_action :require_login, :except => [:new, :create]
  skip_before_action :require_login, :only => [:new, :create, :index, :show]

  def index
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_profile_url @user
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome"
      redirect_to edit_user_profile_path(current_user)
    else
      flash[:error] = "Try again"
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def whitelisted_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 { profile_attributes: [:birthday,
                                   :gender,
                                   :first_name,
                                   :last_name]}
                                 )
  end

end
