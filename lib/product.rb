# frozen_string_literal: true

Product = Struct.new(:id, :title, :price, :remaining_count) do
  def description
    "#{id}: #{title}, $#{price.to_i / 100.0} (#{count} in stock)"
  end

  def in_stock?
    count.positive?
  end

  def decrease_count
    return unless in_stock?

    self.remaining_count -= 1
  end

  private

  def count
    remaining_count.to_i
  end
end
