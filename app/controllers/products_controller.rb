class ProductsController < ApplicationController
  before_action :set_product, only: [:sync]

  def index
    authorize! :read, Product

    @products = Product.all
    @products = @products.pending if params[:pending]

    render json: @products
  end

  def sync
    authorize! :sync, Product

    if @product.update_attributes(product_params)
      render json: @product
    else
      render json: {error: @product.error}
    end
  end

  private def product_params
    params.require(:product).permit(
      :name,
      :brand,
      :product_url,
      :ingredients_string
    ).merge(is_pending: false)
  end

  private def set_product
    id = params.dig(:product, :id)
    @product = Product.find(id)
  end
end
