# frozen_string_literal: true

class Interest < ApplicationRecord
  belongs_to :product, dependent: :destroy

  validates_uniqueness_of :product_id, scope: :user_id
  validates_presence_of :user_id, :product_id, :score

  validates :score, numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 10
            }
end
