# frozen_string_literal: true

require 'coin'

class UserPayment
  def initialize(amount)
    @amount = amount
  end

  def collect
    take_coin while @amount.positive?

    user_coins
  end

  private

  def take_coin
    coin = read_value

    if coin.valid?
      user_coins << coin.value
      @amount -= coin.value
    else
      puts 'Invalid value'
    end
  end

  def read_value
    puts "Please, enter the coin value: ($#{@amount / 100.0} left)"

    Coin.new gets.to_i
  end

  def user_coins
    @user_coins ||= []
  end
end
