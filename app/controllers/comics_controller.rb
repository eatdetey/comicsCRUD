class ComicsController < ApplicationController
  def index
    @comics = Comic.all
  end

  def new
    @comic = Comic.new
  end
  
  def create
    @comic = Comic.new(comic_params)
    if @comic.save
      redirect_to comics_path
    else
      render :new
    end
  end

  def edit
    @comic = Comic.find_by id: params[:id]
  end

  def update
    @comic = Comic.find_by id: params[:id]
    if @comic.update comic_params
      redirect_to comics_path
    else
      render :edit
    end
  end

  def destroy
    @comic = Comic.find_by id: params[:id]
    @comic.destroy
    redirect_to comics_path 
  end

  def show 
    @comic = Comic.find_by id: params[:id]
  end

  private

  def comic_params
    params.require(:comic).permit(:title)
  end

end
