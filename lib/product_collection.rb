# frozen_string_literal: true

require 'product'

class ProductOutOfStockError < StandardError; end

class ProductCollection
  attr_reader :products

  def initialize(products)
    @products = products
  end

  def in_stock
    products.select(&:in_stock?)
  end

  def take(id)
    item = find(id)
    raise ProductOutOfStockError, item unless item.in_stock?

    item.decrease_count

    item
  end

  def find(id)
    products.detect { |item| item.id == id }
  end
end
