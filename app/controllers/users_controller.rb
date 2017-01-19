class UsersController < ApplicationController
  include UserCheck

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, except: [:index, :show, :new, :create]

  skip_before_action :authenticate, only: [:new, :create]

  def create
    @user = User.new(whitelisted)
    if @user.save
      sign_in(@user)
      flash[:success] = ["Successfully signed up!"]
      redirect_to users_path
    else
      flash.now[:danger] = ["Something went wrong signing up"]
      @user.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
      render :new
    end
  end

  def edit
  end

  def index
    @user = current_user
    @post = current_user.posts.build
    allowed_ids = [current_user.id, *current_user.friend_ids]
    @posts = Post.includes(:comments).where(post_type: "Post", user_id: allowed_ids).order(created_at: :desc)
  end

  def new
    create_session unless session[:user_id]
    if signed_in_user?
      redirect_to users_path
    end
    @user = User.new
    @user.build_profile
  end

  def show
    @post = current_user.posts.build
    @posts = Post.includes(:comments).where(post_type: "Post", user_id: @user.id).order(created_at: :desc)
    render :index
  end

  def update
    if @user.authenticate(params[:user][:current_password])
      if @user.update(whitelisted)
        flash[:success] = ["Account Edited!"]
        redirect_to @user
      else
        flash.now[:danger] = ["Something went wrong"]
        @user.errors.full_messages.each do |error|
          flash.now[:danger] << error
        end
        render :edit
      end
    else
      flash.now[:danger] = ["Something went wrong",
                            "Current Password Required to change account credentials"]
      render :edit
    end
  end

  private

    def whitelisted

      params.require(:user).permit(
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    {
                                      profile_attributes:[
                                                          :id,
                                                          :first_name,
                                                          :last_name,
                                                          :birthday,
                                                          :gender
                                                         ]
                                    }
                                  )
    end

end
