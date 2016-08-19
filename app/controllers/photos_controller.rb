class PhotosController < ApplicationController

  before_action :require_current_user, except: [:show, :index]

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def new
    @photo = current_user.photos.build
  end

  def show
    @photo = Photo.find(params[:id])
    @photo_id = @photo.id.to_s
    @user_id = params[:user_id].to_i
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Your photo has been uploaded!"
      redirect_to user_photos_path(current_user)
    else
      flash[:danger] = "Your photo could not be uploaded"
      redirect_to user_photos_path(current_user)
    end
  end


  def update

  end

  def destroy

  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
  
end
