# frozen_string_literal: true

class Coin
  VALID_VALUES = [5, 10, 25, 50].freeze

  attr_reader :value

  def initialize(value)
    @value = value.to_i
  end

  def self.acceptable
    VALID_VALUES.map { |value| new(value).to_s }.join(', ')
  end

  def valid?
    VALID_VALUES.include?(value)
  end

  def to_s
    "#{value}¢"
  end
end
