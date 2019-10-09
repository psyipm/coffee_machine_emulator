# frozen_string_literal: true

require 'change'

RSpec.describe Change do
  let(:coin_stack) do
    {
      50 => 3,
      25 => 5,
      10 => 2,
      5 => 2
    }
  end

  let(:collection) { CoinCollection.new(coin_stack) }
  let(:change) { described_class.new(collection, 125) }

  it 'should calculate change' do
    expect(change.calculate).to match_array [50, 50, 25]
  end

  it 'should calculate change' do
    coin_stack[25] = 0

    expect(change.calculate).to match_array [50, 50, 10, 10, 5]
  end

  it 'should calculate change' do
    coin_stack[50] = 0

    expect(change.calculate).to match_array [25] * 5
  end

  it 'should raise error if not enough change' do
    coin_stack[50] = 0
    coin_stack[25] = 0

    expect { change.calculate }.to raise_error(NotEnoughCoinsError)
  end
end
