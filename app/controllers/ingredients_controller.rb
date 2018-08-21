class IngredientsController < ApplicationController
  caches_action :index
  
  def index
    render json: Ingredient.all
  end
end
