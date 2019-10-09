# frozen_string_literal: true

require 'product_collection'

RSpec.describe ProductCollection do
  let(:product) { Product.new(1, 'Coffee', 1.25, 1) }
  let(:collection) { described_class.new([product]) }

  it 'should list products in stock' do
    expect(collection.in_stock).to contain_exactly(product)
  end

  it 'should find product' do
    expect(collection.find(product.id)).to eq product
  end

  it 'should remove product' do
    expect(collection.in_stock.size).to eq 1
    expect(collection.take(product.id)).to eq product
    expect(collection.in_stock).to be_empty
  end

  it 'should raise error when taking product that is not in stock' do
    product.remaining_count = 0

    expect(collection.in_stock).to be_empty

    expect { collection.take(product.id) }
      .to raise_error(ProductOutOfStockError)
  end
end
