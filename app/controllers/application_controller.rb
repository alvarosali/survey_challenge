# frozen_string_literal: true

class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['SURVEY_USER'], password: ENV['SURVEY_PASSWORD']
  skip_before_action :verify_authenticity_token
end
