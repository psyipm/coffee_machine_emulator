# frozen_string_literal: true

require 'product'

RSpec.describe Product do
  let(:product) { described_class.new(1, 'Coffee', 125, 1) }
  let(:description) { "#{product.id}: #{product.title}, $#{product.price / 100.0}" }

  it 'should return description' do
    expect(product.description).to include(description)
  end

  it 'should decrease remaining count' do
    expect(product.remaining_count).to eq 1

    expect { product.decrease_count }
      .to change { product.in_stock? }.from(true).to(false)
  end

  it 'should check in_stock' do
    expect(product.in_stock?).to eq true
  end
end
