class CategoriesController < ApplicationController
  before_action :set_categories

  def index
  end

  def show
    @category = Category.find_by(id: params[:id])
    respond_to do |format|
      format.html
      format.json {render json: @category, include: ['gifts','gifts.**', 'users']}
    end
  end

  private

  def set_categories
    @categories = Category.all.order(:name)
  end
end
