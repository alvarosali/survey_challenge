# frozen_string_literal: true

require 'rails_helper'

describe 'products' do
  it do
    expect(put: 'products').to route_to(
      controller: 'products',
      action: 'update'
    )
  end
end
