class ListsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
  end

  def new
  end

  def edit
  end

  def show
  end
end
