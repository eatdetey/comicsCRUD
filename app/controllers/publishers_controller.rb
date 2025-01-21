class PublishersController < ApplicationController
  before_action :set_publisher, only: %i[show edit update destroy]

  def index
    @publishers = Publisher.all
  end

  def show
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.save
      redirect_to @publisher, notice: 'Publisher was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @publisher.update(publisher_params)
      redirect_to @publisher, notice: 'Publisher was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @publisher.destroy
    redirect_to publishers_path, notice: 'Publisher was successfully deleted.'
  end

  private

  def set_publisher
    @publisher = Publisher.find(params[:id])
  end

  def publisher_params
    params.require(:publisher).permit(:name)
  end
end
