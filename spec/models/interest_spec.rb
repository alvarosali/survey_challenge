# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interest, type: :model do
  let(:interest) { create(:interest) }

  it 'should have valid factory' do
    expect(interest).to be_valid
  end

  context 'validating the user_id' do
    it 'should be invalid without user_id' do
      interest.user_id = nil
      expect(interest).to be_invalid
    end
  end

  context 'validating the score' do
    it 'should be invalid without score' do
      interest.score = nil
      expect(interest).to be_invalid
    end

    it 'should be invalid with out of range score' do
      interest.score = 11
      expect(interest).to be_invalid
    end
  end

  context 'validating duplicated interests' do
    let(:other_interest) do
      build(:interest, user_id: interest.user_id, product_id: interest.product_id)
    end

    it 'should be invalid with same user and product ID' do
      expect(other_interest).to be_invalid
    end
  end
end
