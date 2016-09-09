require 'byebug'

def range(start, ending)
  return [] if start > ending
  return [start] if start == ending
  return [start] + range(start + 1, ending)
end

def sum_arr(arr)

end

def sum_arr_irr(arr)

end

def exp1(b,n)
  return 1 if n == 0
  return b * exp1(b, n - 1)
end

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1
  return exp2(b, n / 2) ** 2 if n.even?
  return b * (exp2(b, (n - 1)/ 2) ** 2)
end

class Array
  def deep_dup
    return self if length <= 1
    arr = []
    each do |el|
      arr << (el.is_a?(Array) ? el.deep_dup : el)
    end
    arr
  end
end

def fibonacci(n)
  return [] if n == 0
  return [0] if n == 1
  return [0,1] if n == 2
  f_arr = fibonacci(n - 1)
  f_arr << (f_arr[-1] + f_arr[-2])
  f_arr
end

def fib_itr(n)
  return [] if n == 0
  return [0] if n == 1
  return [0,1] if n == 2
  arr = [0,1]
  3.upto(n) do |i|
    arr << (arr[-1] + arr[-2])
  end
  arr
end

def bsearch(arr, target)
  return nil unless arr.include?(target)
  mid = arr.length / 2
  return mid if arr[mid] == target
  return bsearch(arr.take(mid),target) if arr[mid] > target
  return mid + bsearch(arr.drop(mid),target) if arr[mid] < target
end

class Array
  def merge_sort
    return self if length <= 1
    mid = length / 2
    left = take(mid)
    right = drop(mid)
    merge(left.merge_sort, right.merge_sort)

  end

  def merge(arr1, arr2)
    arr = []
    until arr1.empty? || arr2.empty?
      case arr1.first <=> arr2.first
      when -1
        arr << arr1.shift
      when 0
        arr << arr1.shift
      when 1
        arr << arr2.shift
      end
    end
    arr + arr1 + arr2
  end

end

def subset2(arr)
  return [[]] if arr.empty?
  return [[], arr] if arr.length == 1

  # arr length == 2
  sub_arr = subset2(arr.take(arr.length - 1))
  p sub_arr
  sub_arr + sub_arr.map {|el| el + [arr.last]}
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
