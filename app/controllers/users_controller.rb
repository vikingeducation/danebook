class UsersController < ApplicationController
  def new
    @user = User.new
    redirect_to current_user if current_user
  end

  def index
    @users = User.search(params[:name])
  end

  def create
    @user = User.new(params_hash)

    if @user.save
      sign_in @user
      flash[:success] = "Successfully created a user"
      redirect_to @user
    else
      flash[:error] = "There was an error creating your account."
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
    if @user.update(params_hash)
      flash[:success] = "Successfully updated your information!"
      redirect_to @user
    else
      flash[:error] = "There was an error updating your information."
      redirect_to @user
    end
  end

  def destroy
  end

  private

    def params_hash
      params.require(:user).permit(:first_name,
                                    :last_name,
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    :dob,
                                    :gender,
                                    :profile_photo,
                                    :cover_photo,
                                    profile_attributes: [:college,
                                                         :hometown,
                                                         :location,
                                                         :telephone,
                                                         :words,
                                                         :about])
    end
end
