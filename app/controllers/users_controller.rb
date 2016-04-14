class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create, :index]
  # TODO: 
  # before_action :require_logout, only: [:new]
  before_action :require_current_user, :only => [:edit, :update, :destroy]




  def index
    @users = User.search(params[:query])
    render layout: 'newsfeed'
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(whitelisted_params)
    if @user.save
      User.delay.send_welcome_email(@user.id)
      flash[:success] = "User has been created"
      sign_in(@user)
      redirect_to edit_user_profile_path(@user)
    else
      flash[:error] = "User was not created"
      render :new
    end
  end


  def show
    @user = User.find(params[:id])
  end


  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update(whitelisted_params)
      flash[:success] = "User has been updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "User was not updated"
      render :edit
    end
  end


  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "User was deleted"
      sign_out(@user)
    else
      flash[:error] = "User was not deleted"
    end
    redirect_to users_path
  end







  private

  def whitelisted_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :birthday, :gender)
  end

end
