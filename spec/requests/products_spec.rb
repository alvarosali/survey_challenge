# frozen_string_literal: true

require 'rails_helper'

describe 'products', type: :request do
  include AuthHelper

  let(:body) do
    {
      products: [
        {
          id: 'first',
          name: 'first product',
          category: 'sample_products'
        },
        {
          id: 'second',
          name: 'second product',
          category: 'sample_products'
        }
      ]
    }
  end

  let(:headers) { http_auth }

  before(:each) { put '/products', headers: headers, params: body }

  context 'when request has valid authentication' do
    context 'and body has a valid products array' do
      it { expect(response).to be_success }
    end

    context 'and body has a invalid product' do
      let(:body) do
        {
          products: [
            {
              id: 'first',
              name: 'first product',
              category: 'sample products'
            }
          ]
        }
      end

      it 'returns a validation error' do
        expect(response).to be_bad_request
        body = JSON.parse(response.body)
        expect(body.dig('invalid_products', 0, 'errors')).to eq('category' => ['is invalid'])
      end
    end
  end

  context 'when request has not a valid authentication' do
    let(:headers) { nil }

    it { expect(response).to be_unauthorized }
  end
end
