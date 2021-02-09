require 'pry'
# Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day. It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

#   > stock_picker([17,3,6,9,15,8,6,1,10])
#   => [1,4]  # for a profit of $15 - $3 == $12
# Quick Tips:

# You need to buy before you can sell
# Pay attention to edge cases like when the lowest day is the last day or the highest day is the first day.

def stock_picker(array)
  hash = Hash.new(0)
  array.each_with_index do |stock_price, day_bought|
    hash[:prev_gain] = 0
    hash[:prev_price] = 0
    hash[:day_bought] = day_bought
    hash[:sell_day] = hash[:day_bought]
    current_day = day_bought
    new_hash = array[day_bought..].inject(hash) do |result, current_price|
      result[:current_price] = current_price
      result[:current_gain] = result[:current_price] - stock_price
      if result[:current_gain] > result[:prev_gain]
        result[:sell_day] = current_day
        result[:prev_gain] = result[:current_gain]
      end
      current_day += 1
      result
    end
    hash[day_bought] = new_hash[:sell_day]
  end
  hash.delete_if {|key,value| key.is_a?(Symbol)}
  counter = 0
  my_array = hash.values
  p my_array
  pair = my_array.inject([0, 0]) do |pair, sell_day|
    if array[sell_day] - array[counter] > array[pair[1]] - array[pair[0]]
      pair = [counter, sell_day]
    end
    counter += 1
    pair
  end
  puts pair
end

stock_picker([17,3,6,9,15,8,6,1,10])

