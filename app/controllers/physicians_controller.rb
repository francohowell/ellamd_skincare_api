class PhysiciansController < ApplicationController
  caches_action :index
  
  def index
    authorize! :read, Physician
    render json: Physician.all
  end
end
