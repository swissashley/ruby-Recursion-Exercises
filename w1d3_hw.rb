def sum_to(n)
  return nil if n < 0
  return 1 if n == 1
  n + sum_to(n - 1)

end

def add_numbers(arr = nil)
  return nil if arr == nil
  return arr[0] if arr.length == 1
  arr[0] + add_numbers(arr[1..-1])
end

def gamma_fnc(num)
  return nil if num == 0
  return 1 if num == 1
  (num - 1) * gamma_fnc(num - 1)

end

def range(start, ending)
  return [] if start > ending
  return [start] if start == ending
  # range(1,3 ==> )[1,2,3]
  # [1] + [2,3]

  return [start] + range(start + 1, ending)
end
