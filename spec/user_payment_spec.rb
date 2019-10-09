# frozen_string_literal: true

require 'user_payment'

class FakeInput
  def initialize(stubbed_input)
    @stubbed_input = Array(stubbed_input)
  end

  def gets
    @stubbed_input.shift
  end
end

RSpec.describe UserPayment do
  after(:each) do
    $stdin = STDIN
  end

  it 'should read values from console' do
    $stdin = FakeInput.new %w[50 50 25]

    coins = described_class.new(125).collect

    expect(coins).to match_array [50, 50, 25]
  end
end
