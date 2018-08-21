class ConditionsController < ApplicationController
  caches_action :index
  
  def index
    render json: Condition.all
  end
end
