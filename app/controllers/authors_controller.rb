class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit update destroy]

  def index
    handle_db_error do
      @authors = Author.all
    end
  end

  def show
    handle_db_error do
    end
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    handle_db_error do
      if @author.save
        redirect_to @author
      else
        render :new
      end
    end
  end

  def edit
    handle_db_error do
    end
  end

  def update
    handle_db_error do
      if @author.update(author_params)
        redirect_to @author
      else
        render :edit
      end
    end
  end

  def destroy
    handle_db_error do
      if @author.comics.any?
        flash[:alert] = "Cannot delete author because they are associated with existing comics."
        redirect_to authors_path
      else
        @author.destroy
        redirect_to authors_path
      end
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
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
