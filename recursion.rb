require 'byebug'

def range(start, ending)
  return [] if ending < start
  return [start] if start == ending

  # start, start + 1
  [start] + range(start + 1, ending)
end

def sum_arr(arr)
  return nil if arr.empty?
  return arr.first if arr.length == 1
  arr.first + sum_arr(arr[1..-1])

end

def sum_arr_irr(arr)
  sum = 0
  arr.each do |num|
    sum += num
  end
  sum
end

def exp1(b,n)
  return (b ** n) if n < 0
  return 1 if n == 0
  b * exp1(b, n - 1)

end

def exp2(b, n)
  return (b ** n) if n < 0
  return 1 if n == 0

  even_exp = exp2(b, n / 2)
  return even_exp * even_exp if n.even?

  odd_exp = exp2(b, (n - 1) / 2)
  b * (odd_exp * odd_exp)

end

class Array
  def deep_dup
    # return [] if arr.empty?
    arr_copy = []
    self.each do |el|
      if el.is_a?(Array)
        arr_copy << el.deep_dup
      else
        arr_copy << el
      end
    end
    arr_copy
    # return arr unless arr.is_a?(Array)
  end
end

def fibonacci(n)
  return [] if n <= 0
  return [1] if n == 1
  return [1,1] if n == 2
  prev_arr = fibonacci(n-1)
  prev_arr << prev_arr[-1] + prev_arr[-2]
end

def fib_itr(n)
  return [] if n <= 0
  return [1] if n == 1
  return [1,1] if n == 2
  new_arr = [1,1]
  3.upto(n) do |i|
    new_arr << new_arr[-1] + new_arr[-2]
  end
  new_arr
end

def bsearch(arr, target)
  return nil unless arr.include?(target)

  pivot = arr.length / 2
  return pivot if arr[pivot] == target
  high_low = arr[pivot] <=> target
  if high_low == 1
    pivot = bsearch(arr[0...pivot], target)
  else
    pivot += bsearch(arr[pivot..-1], target)
  end
end

class Array
  def merge_sort
    # debugger
    return self if self.length <= 1
    pivot = self.length / 2
    left_arr = self.take(pivot)
    right_arr = self.drop(pivot)

    merge(left_arr.merge_sort, right_arr.merge_sort)

  end

  def merge(arr1, arr2)
    # debugger
    return_array = []

    until arr1.empty? && arr2.empty?
      return_array << arr1.shift if arr2.length == 0
      return_array << arr2.shift if arr1.length == 0 && !arr2.empty?
      compare = arr1.first <=> arr2.first
      return_array << arr2.shift if compare == 1
      return_array << arr1.shift if compare == -1
    end
    return_array
  end

end

def subset2(arr)

  return [[]] if arr.length == 0

  prev_set = subset2(arr[0...-1])
  set = prev_set.deep_dup.map { |set| set << arr.last }

  prev_set + set

end

def greedy_make_change(amount, coins)
  sorted_coins = coins.sort.reverse
  coins_used = []

  (amount / sorted_coins[0]).times { coins_used << sorted_coins[0] }
  amt_left = amount % coins[0]
  coins_used.concat(greedy_make_change(amt_left, coins[1..-1])) unless amt_left == 0

  coins_used

end

def make_better_change(amount, coins)
  # debugger
  return [] if amount == 0
  return nil if coins.none? { |coin| coin <= amount }
  # debugger
  sorted_coins = coins.sort.reverse
  best_change = nil

  sorted_coins.each_with_index do |coin, index|
    next if coin > amount
    remainder = amount - coin
    change = make_better_change(remainder, sorted_coins.drop(index))
    # debugger
    next if change.nil?
    this_change = [coin] + change
    # debugger
    if (best_change.nil? || (this_change.length < best_change.length))
      best_change = this_change
    end
  end

  best_change
end
