# frozen_string_literal: true

require 'rails_helper'

describe 'interests' do
  it do
    expect(post: 'interests').to route_to(
      controller: 'interests',
      action: 'create',
      format: :json
    )
  end
end
