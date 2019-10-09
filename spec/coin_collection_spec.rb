# frozen_string_literal: true

require 'coin_collection'

RSpec.describe CoinCollection do
  let(:collection) { described_class.new }
  let(:p5) { Coin.new(5) }
  let(:p10) { Coin.new(10) }
  let(:p50) { Coin.new(50) }

  it 'should calculate total amount' do
    expect(collection.total).to eq 0

    collection.add p50
    expect(collection.total).to eq 50

    collection.add p50
    expect(collection.total).to eq 100

    collection.add p50
    collection.add p5
    collection.add p10
    expect(collection.total).to eq 165
  end

  it 'should remove coin' do
    collection.add(p10)

    expect(collection.total).to eq 10
    expect(collection.take(10)).to eq 10
    expect(collection.total).to eq 0

    expect(collection.take(10)).to be_nil
  end

  it 'should return coins' do
    collection.upload([50, 50, 10])
    collection.chargeback([50, 10])

    expect(collection.total).to eq 50
  end
end
