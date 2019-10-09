# frozen_string_literal: true

require_relative 'boot'

require 'product_collection'
require 'user_payment'
require 'change'

class Machine
  attr_reader :products, :coins

  def initialize(products, coins)
    @products = products
    @coins = coins
  end

  def run
    print_debug_info

    show_available_products
    product = select_product
    return unless process_payment(product.price)

    sell_product(product)
  end

  def out_of_order?
    products.in_stock.empty?
  end

  private

  def print_debug_info
    puts "Remaining coins: #{coins.coins}, total: $#{coins.total / 100.0}"
    puts "\n\n\n"
  end

  def show_available_products
    puts 'Hello! Please pick an item:'

    products.in_stock.each do |item|
      puts item.description
    end
  end

  def select_product
    puts 'Enter number:'

    selection = gets.to_i
    item = products.find(selection)

    return item if item&.in_stock?

    puts 'Invalid selection'
    exit(1)
  end

  def process_payment(payment_amount)
    puts "The machine accepts only #{Coin.acceptable} coins"

    user_coins = UserPayment.new(payment_amount).collect
    coins.upload(user_coins)

    return_change(user_coins.sum - payment_amount)
  rescue NotEnoughCoinsError => _e
    puts 'Error! Unable to return change.'
    puts "Please, take your money: #{coins.chargeback user_coins}"
  end

  def return_change(change_amount)
    return true if change_amount.zero?

    user_change = Change.new(coins, change_amount).calculate
    puts "Please, take your change: #{user_change.inspect}"

    true
  end

  def sell_product(product)
    products.take product.id
    puts "Please, take your #{product.title}. Bye!"
  end
end

products = ProductCollection.new(
  [
    Product.new(1, 'Americano', 115, 1),
    Product.new(2, 'Capuccino', 175, 1),
    Product.new(3, 'Espresso', 125, 2),
    Product.new(5, 'Macchiato', 155, 1),
    Product.new(4, 'Latte', 145, 1)
  ]
)

coins = CoinCollection.new(
  50 => 3,
  25 => 0,
  10 => 0,
  5 => 0
)

machine = Machine.new(products, coins)

machine.run until machine.out_of_order?

puts 'Machine out of order'
