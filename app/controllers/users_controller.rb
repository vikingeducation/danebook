class UsersController < ApplicationController

  # Whitelist
  skip_before_action :logged_in_user, except: [:edit, :update, :index, :destroy]
  skip_before_action :correct_user, except: [:edit, :update, :destroy]
  before_action :set_user, except: [:index, :new, :create]
  before_action :not_logged_in, only: [:new,:create]


  def index
    #will_paginate requires an instance variable.
    @users = User.search(params[:search], params[:page], current_user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new({ email: user_params[:email],
                       password: user_params[:password],
                       password_confirmation: user_params[:password_confirmation] })
    if @user.save && @user.create_profile!(first_name: user_params[:first_name],
                                           last_name: user_params[:last_name])
      flash[:info] = 'You have been sent an email containing a link to activate your account.'
      queue_activation_email(@user)
      queue_recommended_friends_email(@user)
      redirect_to root_url
    else
      flash[:danger] = 'Invalid information. Please try again to sign up.'
      redirect_to new_user_path
    end
  end


  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash[:danger] = "Could not update profile!"
      redirect_to edit_user_path(@user)
    end
  end

  def show
    @profile = @user.profile
  end

  def destroy
    user.destroy
    flash[:success] = Account has been deleted.
    redirect_to root_path
  end

  def change_avatar
    render 'static_pages/change_avatar'
  end

  private
    def user_params
      permissible_params = [:first_name,
                            :last_name,
                            :email,
                            :password,
                            :password_confirmation,
                            :avatar]
      params.require(:user).permit(permissible_params)
    end

    def queue_activation_email(user)
      UserMailer.activation(user).deliver!
      # UserActivationJob.set(wait: 5.seconds).perform_later(user.id)
    end

    def queue_recommended_friends_email(user)
      other_users = User.search('',1,user)
      other_users_ids = other_users.ids
      RecommendedFriendsJob.set(wait: 15.seconds).perform_later(user.id,other_users_ids)
    end

    # Setting a user before specific actions.
    def set_user
      case action_name
      when 'show'
        @user = User.find_by_id(params[:id])
      when 'edit', 'update', 'destroy', 'change_avatar'
        @user = current_user
      end
      redirect_to :back, :flash => {:error => 'Unable to find that user'} unless @user
    end

    def not_logged_in
      if logged_in?
        flash[:info] = "You are already logged in."
        redirect_to current_user.timeline
      end
    end

end
