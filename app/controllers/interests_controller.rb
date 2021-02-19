# frozen_string_literal: true

class InterestsController < ApplicationController
  def create
    interest = Interest.new(interest_params)

    if interest.valid?
      interest.save
      render json: { message: 'Interest added!' }, status: :ok
    else
      render json: { errors: interest.errors.messages }, status: :bad_request
    end

  rescue ActionController::ParameterMissing
    render json: { errors: 'Bad parameters' }, status: :bad_request
  end

  private def interest_params
    params.require(:interest).permit(:user_id, :product_id, :score)
  end
end
