class PhotosController < ApplicationController
  def new
    @photo = current_user.photos.new
  end

  def create
    @photo = current_user.photos.create!(photos_params)
    if @photo.save
      redirect_to photo_path(@photo)
    else
      render 'static/pages/home'
    end
  end

  def show
      @photo = Photo.find(params[:id])
  end

  private 
  def photos_params
    params.require(:photo).permit(:image)
  end
  
end

