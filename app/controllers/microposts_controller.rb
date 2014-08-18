class MicropostsController < ApplicationController

  def index
    @microposts = Micropost.all
  end


  def show
    @micropost = Micropost.find(params[:id])
  end


  def new
    @micropost = Micropost.new
  end


  def edit
    @micropost = Micropost.find(params[:id])
  end


  def create
    @micropost = Micropost.new(micropost_params)
    if @micropost.save
      redirect_to micropost_path(@micropost)
    else
      render 'new'
    end
  end


  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      redirect_to micropost_path(@micropost)
    else 
      render 'edit'
    end
  end


  def destroy
    Micropost.find(params[:id]).destroy
    redirect_to microposts_path
  end

  
  private
  def micropost_params
    params.require(:micropost).permit(:content, :user_id)
  end
end

