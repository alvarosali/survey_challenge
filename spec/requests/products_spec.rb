# frozen_string_literal: true

require 'rails_helper'

describe 'products', type: :request do
  include AuthHelper

  let(:headers) { http_auth }

  describe 'PUT :products' do
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

    before(:each) { put '/products', headers: headers, params: body }

    context 'when request has valid authentication' do
      context 'and body has a valid products array' do
        it { expect(response).to have_http_status(:successful) }
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

  describe 'GET :products' do
    let(:query_type) { 'score' }
    let(:query_limit) { rand(2..4) }
    let(:query_reverse) { false }
    let(:params) do
      {
        q: query_type,
        limit: query_limit,
        reverse: query_reverse
      }
    end
    let(:categories) { %w[category_one category_two]}

    let!(:products) do
      rand(query_limit..10).times do
        product = create(:product, category: categories.sample)

        rand(1..5).times { create(:interest, product_id: product.id) }
      end
    end

    before(:each) { get '/products', headers: headers, params: params }

    context 'when request has valid authentication' do
      context 'and query has valid params' do
        it { expect(response).to have_http_status(:successful) }

        context 'and there are some products and interests in database' do
          it 'return results limited by limit param' do
            expect(JSON.parse(response.body).count).to eq(query_limit)
          end

          it 'return results ordered by score' do
            results = JSON.parse(response.body)
            expect(results.first['score']).to be <= results.last['score']
          end
        end
      end

      context 'and missing :q param' do
        let(:params) do
          {
            limit: query_limit,
            reverse: query_reverse
          }
        end

        it 'returns a validation error' do
          expect(response).to be_bad_request
          body = JSON.parse(response.body)
          expect(body).to eq('errors'=>'Bad parameters')
        end
      end

      context 'and missing :limit param' do
        let(:params) do
          {
            q: query_type,
            reverse: query_reverse
          }
        end

        it 'returns a validation error' do
          expect(response).to be_bad_request
          body = JSON.parse(response.body)
          expect(body).to eq('errors'=>'Bad parameters')
        end
      end
    end

    context 'when request has not a valid authentication' do
      let(:headers) { nil }

      it { expect(response).to be_unauthorized }
    end
  end

  describe 'GET :categories' do
    let(:query_type) { 'score' }
    let(:query_limit) { rand(2..4) }
    let(:query_reverse) { true }
    let(:params) do
      {
        q: query_type,
        limit: query_limit,
        reverse: query_reverse
      }
    end
    let(:categories) { %w[category_one category_two category_three category_four]}

    let!(:products) do
      rand(query_limit..10).times do
        product = create(:product, category: categories.sample)

        rand(1..5).times { create(:interest, product_id: product.id) }
      end
    end

    before(:each) { get '/categories', headers: headers, params: params }

    context 'when request has valid authentication' do
      context 'and query has valid params' do
        it { expect(response).to have_http_status(:successful) }

        context 'and there are some products and interests in database' do
          it 'return results limited by limit param' do
            expect(JSON.parse(response.body).count).to eq(query_limit)
          end

          it 'return results ordered by score' do
            results = JSON.parse(response.body)
            expect(results.first['score']).to be >= results.last['score']
          end
        end
      end

      context 'and missing :q param' do
        let(:params) do
          {
            limit: query_limit,
            reverse: query_reverse
          }
        end

        it 'returns a validation error' do
          expect(response).to be_bad_request
          body = JSON.parse(response.body)
          expect(body).to eq('errors'=>'Bad parameters')
        end
      end

      context 'and missing :limit param' do
        let(:params) do
          {
            q: query_type,
            reverse: query_reverse
          }
        end

        it 'returns a validation error' do
          expect(response).to be_bad_request
          body = JSON.parse(response.body)
          expect(body).to eq('errors'=>'Bad parameters')
        end
      end
    end

    context 'when request has not a valid authentication' do
      let(:headers) { nil }

      it { expect(response).to be_unauthorized }
    end
  end
end
