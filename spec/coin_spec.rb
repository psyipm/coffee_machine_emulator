# frozen_string_literal: true

require 'coin'

RSpec.describe Coin do
  let(:p5) { Coin.new(5) }
  let(:p25) { Coin.new(25) }

  it 'should validate coin nominal' do
    expect(p5.valid?).to eq true
    expect(p25.valid?).to eq true

    expect(Coin.new(12).valid?).to eq false
  end
end
