class PhotosController < ApplicationController

  before_action :require_specific_friends, :only => [:show]

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    @user = current_user
    if params[:url] && url_with_image?(params[:url])
      @photo = current_user.photos.build
      @photo.image_from_url(params[:url])
    else
      @photo = current_user.photos.build(photo_params)
    end
    if @photo.save
      flash[:success] = "Congratulations! You have successfully ulpoaded a photo!"
      redirect_to user_photo_path(current_user, @photo)
    else
      flash[:danger] = "Error! We couldn't upload your photo" + "#{@photo.errors.full_messages}"
      render :new
    end
  end

  def update
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    if params[:type] == 'cover'
      @user.cover_photo_id = @photo.id
    elsif params[:type] == 'profile'
      @user.profile_photo_id = @photo.id
    end
    if @user.save
      flash[:success] = "You have successfully updated photo in your #{params[:type]}"
      redirect_to user_photo_path(current_user, @photo)
    else
      flash[:danger] = "Error! We couldn't update your photo" + "#{@photo.errors.full_messages}"
      redirect_to user_photo_path(current_user, @photo)
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.user_id == current_user.id && @photo.destroy
      nulify_cover_profile_photo(@photo)
      flash[:success] = "You have deleted your photo!"
      redirect_to user_photos_path(current_user.id)
    else
      flash.now[:danger] = "We couldn't delete your photo :("
      redirect_back(fallback_location: root_path)
    end
  end


  private
  def photo_params
    params.permit( :image )
  end

  def nulify_cover_profile_photo(photo)
    current_user.cover_photo_id = nil if current_user.cover_photo_id == photo.id
    current_user.profile_photo_id = nil if current_user.profile_photo_id == photo.id
    current_user.save
  end

end
