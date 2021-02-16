# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }

  it 'should have valid factory' do
    expect(product).to be_valid
  end

  context 'validating the id' do
    it 'should be invalid without id' do
      product.id = nil
      expect(product).to be_invalid
    end

    it 'should be invalid with existing id' do
      expect(build(:product, id: product.id)).to be_invalid
    end
  end

  context 'validating the category' do
    it 'should be invalid without category' do
      product.category = nil
      expect(product).to be_invalid
    end

    it 'should be invalid with bad format category' do
      product.category = 'Bad Format Category'
      expect(product).to be_invalid
    end
  end
end
