# frozen_string_literal: true

module AuthHelper
  def http_auth
    auth_token = ActionController::HttpAuthentication::Basic.encode_credentials(
      ENV['SURVEY_USER'],
      ENV['SURVEY_PASSWORD']
    )

    { 'HTTP_AUTHORIZATION' => auth_token }
  end
end
