# frozen_string_literal: true

class Interest < ApplicationRecord
  belongs_to :product, dependent: :destroy

  validates_uniqueness_of :product_id, scope: :user_id
  validates_presence_of :user_id, :product_id, :score
  validates :score, inclusion: (0..10).to_a
end
