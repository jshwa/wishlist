class CategoriesController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @category = Category.find_by(id: params[:id])
  end
end
