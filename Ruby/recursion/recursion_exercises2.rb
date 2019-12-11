require 'byebug'

# Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.


def range(start, last)
    return [] if start >= last
    
    next_num = start + 1
    [start, *range(next_num, last)]

end

# puts range(1, 5)  # [1, 2, 3, 4]

# puts range(5, 3)  # []

# puts range(3, 12) # [3, 4, 5, 6, 7, 8, 9, 10, 11]



# Write both a recursive and iterative version of sum of an array.
# recursive
def sum_of_array(arr)
    return nil if arr.length < 1
    return arr[0] if arr.length == 1

    arr[0] + sum_of_array(arr[1..-1])
end

#iterative
# def sum_of_array(arr)
#     arr.inject(:+)
# end

# puts sum_of_array([1,2,3,4]) # 10

# puts sum_of_array([]) # 0

# puts sum_of_array([-5, 2, 7, 2, 67]) # 73




# Exponentiation

# Simple exponentiation. Amount of stacks is equal to n.
# def exponent(b, n)
#     return nil if n < 0
#     return 1 if n == 0
#     b * exponent(b, n-1)
# end

# Complex exponentiation. Power is reduced by half for each stack.
def exponent(base, power)
    return nil if power < 0
    return 1 if power == 0
    return base if power == 1

    if power.even?
        pair = exponent(base, power/2)
        pair * pair
    else
        even_power = power - 1 # not necessary since odd num / 2 will equal the same.
        pair = exponent(base, even_power / 2)
        base * pair * pair
    end
end

# puts exponent(5, 2) # 25
# puts exponent(5, 5) # 3125
# puts exponent(5, 0) # 1
# puts exponent(5, 1) # 5
# puts exponent(5, -2) # nil



class Array

    # problem: if we use Array#dup on a multi-dimensional array, 
    # the dup will be a separate array, but each sub_array will
    # still point to the sub_arrays of the original array.

    #Ex:
    # array = [
    #     [1,2,3],
    #     [4,5,6]
    # ]
    # array_copy = array.dup
    # array_copy[1] << 7
    # array_copy # => [[1,2,3],[4,5,6,7]]
    # array # => [[1,2,3],[4,5,6,7]]


    # write Array#deep_dup that will ensure the duplicated array 
    # doesn't mutate the original array.
    def deep_dup
        new_array = []
        self.each do |sub_el|
            # new_array << (sub_el.is_a?(Array) ? sub_el.deep_dup : sub_el )
            if sub_el.is_a?(Array)
                new_array << sub_el.deep_dup                
            else
                new_array << sub_el
            end
        end
        new_array
    end
end


array = [
    [1,2,3],
    [4,5,6]
]
array_copy = array.deep_dup
array_copy[1] << 7
print array_copy # => [[1,2,3],[4,5,6,7]]
print array # => [[1,2,3],[4,5,6]]

array = [1,[2],[3, [4]]]
array_copy = array.deep_dup
array_copy[1] << 3
print array_copy # => [1, [2, 3], [3, [4]]]
print array # => [1, [2], [3, [4]]]




# Fibonacci
# Write a recursive and an iterative Fibonacci method. The method should take in an integer n and return the first n Fibonacci numbers in an array.

# You shouldn't have to pass any arrays between methods; you should be able to do this just passing a single argument for the number of Fibonacci numbers requested.

# Recursive
def fib(n)
    return nil if n < 1
    return [1] if n == 1
    return [1, 1] if n == 2

    smaller_fib = fib(n-1)
    second_to_last_num = smaller_fib[-2]
    last_num = smaller_fib.last
    smaller_fib += [second_to_last_num + last_num]

end

# Iterative
def fib(n)
    return nil if n < 1
    array = [1]
    return array if n == 1
    array << 1
    return array if n == 2

    while array.length < n
        first_num = array[-2]
        second_num = array.last
        array << (first_num + second_num)
    end
    array
end




# Binary Search

def binary_search(array, target)
    mid_index = array.length / 2
    return mid_index if array[mid_index] == target

    if target < array[mid_index]
        half_array = array[0...mid_index]
        return nil if !half_array.include?(target)
        binary_search(half_array, target)
    else
        half_array = array[mid_index..-1]
        return nil if !half_array.include?(target)
        binary_search(half_array, target) + mid_index
    end
end


# binary_search([1, 2, 3], 1) # => 0
# binary_search([2, 3, 4, 5], 3) # => 1
# binary_search([2, 4, 6, 8, 10], 6) # => 2
# binary_search([1, 3, 4, 5, 9], 5) # => 3
# binary_search([1, 2, 3, 4, 5, 6], 6) # => 5
# binary_search([1, 2, 3, 4, 5, 6], 0) # => nil
# binary_search([1, 2, 3, 4, 5, 7], 6) # => nil




def merge_sort(array)
    return array if array.length <= 1

    half_index = array.length.odd? ? array.length / 2 : (array.length / 2) - 1
    left = array[0..half_index]
    right = array[half_index+1..-1]

    
    merge(merge_sort(left), merge_sort(right))

end

def merge(left, right)
    merged = []
    until left.empty? || right.empty?
        merged << (left.first < right.first ? left.shift : right.shift)
    end
    merged + left + right

end




# Array Subsets
class Array
    def subsets
        return [[]] if self.empty?
        subs = self[0...-1].subsets
        subs.concat(subs.map { |sub| sub + [last] })

    end
end

def permutations(array)
    return [array] if array.length <= 1

    first = array.shift
    perms = permutations(array)
    total_perms = []

    perms.each do |perm|
        (0..perm.length).each do |idx|
            total_perms << perm[0...idx] + [first] + perm[idx..-1]
        end
    end
    total_perms

end



# make change, using the biggest coins first

def greedy(amount, coins=[25,10,5,1])
    return [amount] if coins.include?(amount)
    return nil if amount < coins.min
    coins = coins.sort.reverse

    total_coins = []
    remaining_amount = amount

    coins.each do |coin|
        if amount > coin
            total_coins << coin
            remaining_amount -= coin
            return total_coins + greedy(remaining_amount, coins)
        end
    end

    total_coins += greedy(remaining_amount, coins)
end


# greedy make change iterative:

def greedy_iteration(amount, coins = [25, 10, 5, 1])
    change = []
    # relies on coins being in descending order
    coins.each do |coin|
        count = amount / coin
        count.times { change << coin }
        amount = amount - (coin * count)
    end

    change
end

# Another recursive version

def greedy_recursion(amount, coins = [25, 10, 5, 1])
    change = []
    first_coin = coins[0]
    count = amount / first_coin
    count.times { change << first_coin }
    amount = amount - (count * first_coin)

    if amount > 0
        change = change + greedy_recursion(amount, coins.drop(1))
    end


end

# Make the best change, even if it is not necessarily the greedy version:

def make_change(amount, coins = [25,10,5,1])
    return [] if amount == 0

    best_change = nil
    coins.each do |coin|
        next if coin > amount

        change_for_rest = make_change(amount - coin, coins)
        change = [coin] + change_for_rest

        if best_change.nil? || change.count < best_change.count
            best_change = change
        end
        # p "USED 1 #{coin}: "
        # p change
    end
    best_change
end



print make_change(17, [10, 7, 1]) # => [10, 7]

print make_change(14, [10, 7, 1]) # => [7, 7]