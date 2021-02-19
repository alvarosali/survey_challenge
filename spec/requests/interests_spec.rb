# frozen_string_literal: true

require 'rails_helper'

describe 'interests', type: :request do
  include AuthHelper

  let(:user_id) { 'first' }
  let(:product_id) { 'product_1' }
  let(:headers) { http_auth }
  let(:score) { 6 }
  let!(:product) { create(:product, id: product_id) }
  let!(:interest) { create(:interest, user_id: user_id, product_id: product_id) }
  let(:body) do
    {
      "user_id": 'second',
      "product_id": 'product_1',
      "score": score
    }
  end

  before(:each) do
    post(
      '/interests',
      headers: headers.merge('Content-Type' => 'application/json'),
      params: body.to_json
    )
  end

  context 'when request has valid authentication' do
    context 'and body has a valid interest params' do
      it { expect(response).to be_success }
    end

    context 'and body has a non existant product_id' do
      let(:product_id) { 'other_product' }

      it 'returns a validation error' do
        expect(response).to be_bad_request
        body = JSON.parse(response.body)
        expect(body.dig('errors', 'product')).to eq(['must exist'])
      end
    end

    context 'and body has an interest with a already saved user_id and product_id' do
      let(:user_id) { 'second' }

      it 'returns a validation error' do
        expect(response).to be_bad_request
        body = JSON.parse(response.body)
        expect(body.dig('errors', 'product_id')).to eq(['has already been taken'])
      end
    end

    context 'and body has an out of range score' do
      let(:score) { 100 }

      it 'returns a validation error' do
        expect(response).to be_bad_request
        body = JSON.parse(response.body)
        expect(body.dig('errors', 'score')).to eq(['must be less than or equal to 10'])
      end
    end
  end

  context 'when request has not a valid authentication' do
    let(:headers) { {} }

    it { expect(response).to be_unauthorized }
  end
end
