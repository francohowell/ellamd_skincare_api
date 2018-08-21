class PhotosController < ApplicationController
  before_action :set_customer_from_params
  caches_action :index

  def index
    authorize! :read, @customer

    photos = @customer.photos
    if params[:created_after]
      photos = photos.where("created_at > ?", Time.zone.at(params[:created_after]))
    end

    render json: photos
  end

  def create
    authorize! :create_photo, @customer

    photos = (params[:images] || []).map do |image|
      @customer.photos.create!(image: image, customer: @customer)
    end

    @customer.subscription.require_new_treatment_plan

    track("Added a photo", {source: "web"}, @customer)
    render json: photos
  end
end
