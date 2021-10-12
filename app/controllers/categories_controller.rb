class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @categories = current_user.categories
    @categories = @categories.filtered(query_params)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id

    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_path
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title, :description)
    end

    def query_params
      query_params = params[:query]
      query_params ? query_params.permit(:title, :description) : {}
    end
end
