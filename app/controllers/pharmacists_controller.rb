class PharmacistsController < ApplicationController
  caches_action :index
  
  def index
    authorize! :read, Pharmacist
    render json: Pharmacist.includes(:identity).all
  end

  def create
    authorize! :create, Pharmacist

    Pharmacist.transaction do
      @pharmacist = Pharmacist.create!
      Identity.create!(
        user: @pharmacist,
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password],
      )
    end

    render json: @pharmacist
  end
end
