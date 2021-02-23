# frozen_string_literal: true

require 'rails_helper'

describe 'products' do
  it do
    expect(put: 'products').to route_to(
      controller: 'products',
      action: 'update',
      format: :json
    )
  end

  it do
    expect(get: 'products').to route_to(
      controller: 'products',
      action: 'products',
      format: :json
    )
  end

  it do
    expect(get: 'categories').to route_to(
      controller: 'products',
      action: 'categories',
      format: :json
    )
  end
end
