class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]


  def index
    @search_terms = params[:search]
    if @search_terms
      @users = User.search(@search_terms).order(:name)
    else
      @users = User.includes(:profile_pic, :received_friendings, :users_friended_by).all.order(:name)
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    authorize @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to @user, notice: "Hi #{@user.email}! Welcome to Danebook!"
    else
      render :new
    end
  end

  def update
    authorize @user
    if @current_user.update(user_params)
      redirect_to @user, notice: 'Your profile has been updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_digest, :name, :birthday, :college, :hometown, :current_town, :phone, :quote, :bio, :profile_pic_id, :cover_pic_id)
    end
end
