# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :clean_product_database, only: :update

  def update
    @errors = []
    products_params[:products].each do |product_params|
      product = Product.new(product_params)
      if product.valid?
        product.save
      else
        @errors << { product: product_params, errors: product.errors.messages }
      end
    end

    if @errors.empty?
      render json: {}, status: :ok
    else
      render json: { invalid_products: @errors }, status: :bad_request
    end
  end

  private def clean_product_database
    Product.destroy_all
  end

  private def products_params
    params.permit(products: %i[id name category])
  end
end
