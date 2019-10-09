# frozen_string_literal: true

require 'coin_collection'

RSpec.describe CoinCollection do
  let(:collection) { described_class.new }
  let(:p5) { Coin.new(5) }
  let(:p10) { Coin.new(10) }
  let(:p50) { Coin.new(50) }

  it 'should calculate total amount' do
    expect(collection.total).to eq 0

    collection.upload [50]
    expect(collection.total).to eq 50

    collection.upload [50, 5, 10]
    expect(collection.total).to eq 115
  end

  it 'should remove coin' do
    collection.upload [10]

    expect(collection.total).to eq 10
    expect(collection.take(10)).to eq 10
    expect(collection.total).to eq 0

    expect(collection.take(10)).to be_nil
  end

  it 'should return coins' do
    collection.upload([50, 50, 10])
    collection.refund([50, 10])

    expect(collection.total).to eq 50
  end
end
