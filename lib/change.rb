# frozen_string_literal: true

require 'coin_collection'

class NotEnoughCoinsError < StandardError; end

class Change
  attr_reader :collection, :amount

  def initialize(coin_collection, amount)
    @collection = coin_collection
    @amount = amount
  end

  def calculate
    raise NotEnoughCoinsError if amount > collection.total

    while amount.positive?
      value = take_coin

      @amount -= value

      change << value
    end

    change
  end

  private

  def change
    @change ||= []
  end

  def take_coin
    raise NotEnoughCoinsError if available_coins.empty?

    collection.take available_coins.keys.max
  end

  def available_coins
    collection.coins.select do |value, count|
      value <= amount && count.positive?
    end
  end
end
