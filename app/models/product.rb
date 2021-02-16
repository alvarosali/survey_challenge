# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :interests, dependent: :delete_all

  validates_uniqueness_of :id
  validates_presence_of :id, :name, :category
  validates_format_of :category, with: /\A([a-z_]+)\z/
end
