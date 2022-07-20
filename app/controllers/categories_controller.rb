class CategoriesController < ApplicationController
  before_action :require_user_log_in!
  before_action :admin_user
  before_action :set_category, except: %i[index new create]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      respond_to do |format|
        format.js
      end
    end
  end

  def edit; end

  def update
    @category.update(category_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
