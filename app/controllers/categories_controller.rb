class CategoriesController < ApplicationController
  before_action :require_user_log_in!
  before_action :admin_user
  before_action :set_category, except: %i[index new create]
  before_action :check_no_task, only: :destroy
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    respond_to do |format|
      format.js
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

  def check_no_task
    return if @category.tasks.empty?

    redirect_back(fallback_location: root_path,
                  alert: "You can only delete if there is no task of this category")
  end
end
