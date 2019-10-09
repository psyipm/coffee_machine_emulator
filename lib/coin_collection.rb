# frozen_string_literal: true

require 'coin'

class CoinCollection
  attr_reader :coins

  def initialize(coins = nil)
    @coins = coins || Hash.new(0)
  end

  def total
    coins.reduce(0) { |sum, (value, count)| sum + value * count }
  end

  def upload(values)
    values.each { |value| add Coin.new(value) }
  end

  def add(coin)
    coins[coin.value] += 1
  end

  def refund(values)
    values.each { |item| take(item) }
  end

  def take(value)
    return unless coins[value].positive?

    coins[value] -= 1

    value
  end
end
