class PublishersController < ApplicationController
  before_action :set_publisher, only: %i[show edit update destroy]

  def index
    handle_db_error do
      @publishers = Publisher.all
    end
  end

  def show
    handle_db_error do
    end
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(publisher_params)
    handle_db_error do
      if @publisher.save
        redirect_to @publisher
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
      if @publisher.update(publisher_params)
        redirect_to @publisher
      else
        render :edit
      end
    end
  end

  def destroy
    handle_db_error do
      if @publisher.comics.any?
        flash[:alert] = "Cannot delete publisher because it is associated with existing comics."
        redirect_to publishers_path
      else
        @publisher.destroy
        redirect_to publishers_path
      end
    end
  end

  private

  def set_publisher
    @publisher = Publisher.find(params[:id])
  end

  def publisher_params
    params.require(:publisher).permit(:name)
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
