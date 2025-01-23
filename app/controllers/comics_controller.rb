class ComicsController < ApplicationController
  def index
    handle_db_error do
      @comics = Comic.all
    end
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    handle_db_error do
      if @comic.save
        redirect_to comics_path
      else
        render :new
      end
    end
  end

  def edit
    handle_db_error do
      @comic = Comic.find_by id: params[:id]
      if @comic.nil?
        flash[:error] = "Комикс не найден."
        redirect_to comics_path
      end
    end
  end

  def update
    @comic = Comic.find_by id: params[:id]
    handle_db_error do
      if @comic.update comic_params
        redirect_to comics_path
      else
        render :edit
      end
    end
  end

  def destroy
    @comic = Comic.find_by id: params[:id]
    handle_db_error do
      if @comic.nil?
        flash[:error] = "Комикс не найден."
        redirect_to comics_path
      else
        @comic.destroy
        redirect_to comics_path
      end
    end
  end

  def show
    handle_db_error do
      @comic = Comic.find_by id: params[:id]
      if @comic.nil?
        flash[:error] = "Комикс не найден."
        redirect_to comics_path
      end
    end
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :description, :genre, :published_on, :publisher_id, author_ids: [])
  end

  def handle_db_error
    begin
      yield
    rescue ActiveRecord::ConnectionNotEstablished => e
      Rails.logger.error("Ошибка соединения с базой данных: #{e.message}")
      flash[:error] = "Не удалось выполнить операцию с базой данных. Пожалуйста, попробуйте позже."
      redirect_to root_path
    rescue ActiveRecord::StatementInvalid => e
      Rails.logger.error("Ошибка выполнения SQL-запроса: #{e.message}")
      flash[:error] = "Произошла ошибка при выполнении запроса. Пожалуйста, попробуйте позже."
      redirect_to root_path
    end
  end
end
