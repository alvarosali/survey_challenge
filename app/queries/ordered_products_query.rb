# frozen_string_literal: true

class OrderedProductsQuery
  VALID_QUERY_TYPES = %w[score]

  def initialize(params = {}, relation = Product.joins(:interests))
    @relation = relation
    @params = params
  end

  def search
    group_by_request if @params[:request].present?
    limit_results if @params[:limit].present?
    ordered_by_query_type if @params[:q].present?

    @relation
  end

  private def group_by_request
    case @params[:request]
    when 'categories'
      @relation = @relation.group(:category)
    else
      @relation = @relation.group(:product_id, :name, :category)
    end
  end

  private def limit_results
    @relation = @relation.limit(@params[:limit])
  end

  private def ordered_by_query_type
    order = @params[:reverse] == 'true' ? 'desc' : 'asc'

    case @params[:q]
    when 'score'
      @relation = @relation
                    .order(Arel.sql("AVG(score) #{order}"))
                    .average(:score)
    end
  end
end
