class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @categories = current_user.categories.filtered(query_params).order(updated_at: :desc)
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

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.js
      end
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
