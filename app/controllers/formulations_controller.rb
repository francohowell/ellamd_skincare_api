class FormulationsController < ApplicationController
  caches_action :index
  
  def index
    render json: Formulation.includes(:ingredients).all
  end
end
