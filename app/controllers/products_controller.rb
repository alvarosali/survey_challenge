# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :clean_product_database, only: :update
  before_action :find_query_results, only: %i[products categories]

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
      render json: { message: 'All products added!' }, status: :ok
    else
      render json: { invalid_products: @errors }, status: :bad_request
    end

  rescue ActionController::ParameterMissing
    render json: { errors: 'Bad parameters' }, status: :bad_request
  end

  def products; end

  def categories; end

  private def find_query_results
    if OrderedProductsQuery::VALID_QUERY_TYPES.include?(filter_params[:q])
      @result = OrderedProductsQuery.new(filter_params.merge(request: action_name)).search
      render json: format_result, status: :ok
    else
      render json: {
               errors: "Query type must be: [#{OrderedProductsQuery::VALID_QUERY_TYPES.join(', ')}]"
             },
             status: :bad_request
    end
  rescue ActionController::ParameterMissing
    render json: { errors: 'Bad parameters' }, status: :bad_request
  end

  private def clean_product_database
    Product.destroy_all
  end

  private def filter_params
    params.require([:q, :limit])
    params.permit(:q, :limit, :reverse)
  end

  private def products_params
    params.permit(products: %i[id name category])
  end

  private def format_result
    return [] if @result.blank?

    @result.map do |key, value|
      format_by_action(key).merge(score: value.to_f.round(1))
    end
  end

  private def format_by_action(values)
    return { category: values } if action_name == 'categories'

    {
      product: {
        product_id: values[0],
        name: values[1],
        category: values[2]
      }
    }
  end
end
