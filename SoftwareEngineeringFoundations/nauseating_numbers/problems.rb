require "byebug"

#####################################################################
###                            PHASE 1                            ###
#####################################################################


# Write a method strange_sums that accepts an array of numbers as an argument. The method should return a count of the number of distinct pairs of elements that have a sum of zero. You may assume that the input array contains unique elements.

def strange_sums(nums)
    count = 0
    nums.each_with_index do |num, idx|
        nums.each_with_index do |num2, idx2|
            if idx2 > idx
                count += 1 if num + num2 == 0
            end
        end
    end
    count
end

# p strange_sums([2, -3, 3, 4, -2])     # 2
# p strange_sums([42, 3, -1, -42])      # 1
# p strange_sums([-5, 5])               # 1
# p strange_sums([19, 6, -3, -20])      # 0
# p strange_sums([9])                   # 0




# Write a method pair_product that accepts an array of numbers and a product as arguments. The method should return a boolean indicating whether or not a pair of distinct elements in the array result in the product when multiplied together. You may assume that the input array contains unique elements.

def pair_product(nums, product)
    nums.each_with_index do |num1, idx1|
        nums.each_with_index do |num2, idx2|
            if idx2 > idx1
                return true if num1 * num2 == product
            end
        end
    end
    false
end

# p pair_product([4, 2, 5, 8], 16)    # true
# p pair_product([8, 1, 9, 3], 8)     # true
# p pair_product([3, 4], 12)          # true
# p pair_product([3, 4, 6, 2, 5], 12) # true
# p pair_product([4, 2, 5, 7], 16)    # false
# p pair_product([8, 4, 9, 3], 8)     # false
# p pair_product([3], 12)             # false




# Write a method rampant_repeats that accepts a string and a hash as arguments. The method should return a new string where characters of the original string are repeated the number of times specified by the hash. If a character does not exist as a key of the hash, then it should remain unchanged.

def rampant_repeats(str, hash)
    arr = str.split("")
    arr.map do |char|
        if hash.keys.include?(char)
            char * hash[char]
        else
            char
        end
    end.join("")
end

# p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
# p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
# p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
# p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'




# Write a method perfect_square? that accepts a number as an argument. The method should return a boolean indicating whether or not the argument is a perfect square. A perfect square is a number that is the product of some number multiplied by itself. For example, since 64 = 8 * 8 and 144 = 12 * 12, 64 and 144 are perfect squares; 35 is not a perfect square.

def perfect_square(num)
    return true if num == 1
    half = num / 2
    (1..half).each { |square| return true if square * square == num }
    false
end

# p perfect_square(1)     # true
# p perfect_square(4)     # true
# p perfect_square(64)    # true
# p perfect_square(100)   # true
# p perfect_square(169)   # true
# p perfect_square(2)     # false
# p perfect_square(40)    # false
# p perfect_square(32)    # false
# p perfect_square(50)    # false




#####################################################################
###                            PHASE 2                            ###
#####################################################################

# Write a method anti_prime? that accepts a number as an argument. The method should return true if the given number has more divisors than all positive numbers less than the given number. For example, 24 is an anti-prime because it has more divisors than any positive number less than 24. Math Fact: Numbers that meet this criteria are also known as highly composite numbers.

def anti_prime?(num)
    (1...num).each { |n| return false if divisor_count(n) >= divisor_count(num) }
    true

end

def divisor_count(num)
    (1..num).count { |n| num % n == 0}
end

# p anti_prime?(24)   # true
# p anti_prime?(36)   # true
# p anti_prime?(48)   # true
# p anti_prime?(360)  # true
# p anti_prime?(1260) # true
# p anti_prime?(27)   # false
# p anti_prime?(5)    # false
# p anti_prime?(100)  # false
# p anti_prime?(136)  # false
# p anti_prime?(1024) # false




# Let a 2-dimensional array be known as a "matrix". Write a method matrix_addition that accepts two matrices as arguments. The two matrices are guaranteed to have the same "height" and "width". The method should return a new matrix representing the sum of the two arguments.

def matrix_addition(mat1, mat2)
    final = Array.new(mat1.length) { Array.new([])}
    mat1.each_with_index do |subarr, sub_idx|
        subarr.each_with_index do |num, num_idx|
            # debugger
            final[sub_idx][num_idx] = num + mat2[sub_idx][num_idx]
        end
    end
    final
end


matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
# p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
# p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
# p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]




# Write a method mutual_factors that accepts any amount of numbers as arguments. The method should return an array containing all of the common divisors shared among the arguments. For example, the common divisors of 50 and 30 are 1, 2, 5, 10. You can assume that all of the arguments are positive integers.

def mutual_factors(*nums)
    minimum = nums.min
    (1..minimum).select { |n| nums.all? { |num| factors(num).include?(n)}}
end

def factors(num)
    (1..num).select { |factor| num % factor == 0 }
end


# p mutual_factors(50, 30)            # [1, 2, 5, 10]
# p mutual_factors(50, 30, 45, 105)   # [1, 5]
# p mutual_factors(8, 4)              # [1, 2, 4]
# p mutual_factors(8, 4, 10)          # [1, 2]
# p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
# p mutual_factors(12, 24, 64)        # [1, 2, 4]
# p mutual_factors(22, 44)            # [1, 2, 11, 22]
# p mutual_factors(22, 44, 11)        # [1, 11]
# p mutual_factors(7)                 # [1, 7]
# p mutual_factors(7, 9)              # [1]




# The tribonacci sequence is similar to that of Fibonacci. The first three numbers of the tribonacci sequence are 1, 1, and 2. To generate the next number of the sequence, we take the sum of the previous three numbers. 

def tribonacci_number(num)
    return 1 if num == 1 || num == 2
    return 2 if num == 3
    tribonacci_number(num - 1) + tribonacci_number(num - 2) + tribonacci_number(num - 3)
end

# p tribonacci_number(1)  # 1
# p tribonacci_number(2)  # 1
# p tribonacci_number(3)  # 2
# p tribonacci_number(4)  # 4
# p tribonacci_number(5)  # 7
# p tribonacci_number(6)  # 13
# p tribonacci_number(7)  # 24
# p tribonacci_number(11) # 274

#####################################################################
###                            PHASE 3                            ###
#####################################################################

# Write a method matrix_addition_reloaded that accepts any number of matrices as arguments. The method should return a new matrix representing the sum of the arguments. Matrix addition can only be performed on matrices of similar dimensions, so if all of the given matrices do not have the same "height" and "width", then return nil.

def matrix_addition_reloaded(*mates)
    height = mates[0].length
    width = mates[0][0].length
    return nil if mates.any? { |mate| mate.length != height || mate[0].length != width }
    final = Array.new(height) { Array.new([0, 0]) }
    mates.each do |mate|
        mate.each_with_index do |subarr, sub_idx|
            subarr.each_with_index do |num, num_idx|
                final[sub_idx][num_idx] += num 
            end
        end
    end
    final
end


matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
# p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
# p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
# p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil




# Write a method squarocol? that accepts a 2-dimensional array as an argument. The method should return a boolean indicating whether or not any row or column is completely filled with the same element. You may assume that the 2-dimensional array has "square" dimensions, meaning it's height is the same as it's width.

def squarocol?(arr)
    arr.each { |subarr| return true if subarr.all? { |el| el == subarr[0] }}
    hash = Hash.new { |h, k| h[k] = [] }
    arr.each do |subarr|
        subarr.each_with_index do |el, idx|
            hash[idx] << el
        end
    end
    hash.values.any? { |subarr| subarr.all? { |el| el == subarr[0] }}
end

# p squarocol?([
#     [:a, :x , :d],
#     [:b, :x , :e],
#     [:c, :x , :f],
# ]) # true

# p squarocol?([
#     [:x, :y, :x],
#     [:x, :z, :x],
#     [:o, :o, :o],
# ]) # true

# p squarocol?([
#     [:o, :x , :o],
#     [:x, :o , :x],
#     [:o, :x , :o],
# ]) # false

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 7],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # true

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 0],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # false




# Write a method squaragonal? that accepts 2-dimensional array as an argument. The method should return a boolean indicating whether or not the array contains all of the same element across either of its diagonals. You may assume that the 2-dimensional array has "square" dimensions, meaning it's height is the same as it's width.

def squaragonal?(arr)
    diag1 = []
    diag2 = []
    diag_length = arr[0].length
    i = 0
    j = diag_length - 1
    while i < diag_length
        diag1 << arr[i][i]
        diag2 << arr[i][j]
        i += 1
        j -= 1
    end

    diag1.all? { |el| el == diag1[0]} || diag2.all? { |el| el == diag2[0] } 

end

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :x, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :o, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 7],
#     [1, 1, 6, 7],
#     [0, 5, 1, 7],
#     [4, 2, 9, 1],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 5],
#     [1, 6, 5, 0],
#     [0, 2, 2, 7],
#     [5, 2, 9, 7],
# ]) # false




# Write a method pascals_triangle that accepts a positive number, n, as an argument and returns a 2-dimensional array representing the first n levels of pascal's triangle.

def pascals_triangle(num)
    triangle = [[1]]
    while triangle.length < num
        sides = [1]
        mid = sums(triangle[-1])
        new_level = sides + mid + sides
        triangle << new_level
    end
    triangle
end

def sums(arr)
    return [] if arr == [1]
    mid = []
    (0...arr.length-1).each do |idx|
        mid << arr[idx] + arr[idx+1]
    end
    mid
end

# p pascals_triangle(5)
# # [
# #     [1],
# #     [1, 1],
# #     [1, 2, 1],
# #     [1, 3, 3, 1],
# #     [1, 4, 6, 4, 1]
# # ]

# p pascals_triangle(7)
# # [
# #     [1],
# #     [1, 1],
# #     [1, 2, 1],
# #     [1, 3, 3, 1],
# #     [1, 4, 6, 4, 1],
# #     [1, 5, 10, 10, 5, 1],
# #     [1, 6, 15, 20, 15, 6, 1]
# # ]


#####################################################################
###                            PHASE 4                            ###
#####################################################################

# A "Mersenne prime" is a prime number that is one less than a power of 2. This means that it is a prime number with the form 2^x - 1, where x is some exponent.
# The first three Mersenne primes are 3, 7, and 31. Write a method mersenne_prime that accepts a number, n, as an argument and returns the n-th Mersenne prime.

def mersenne_prime(num)
    arr = []
    i = 3
    while arr.length < num
        arr << i if mersenne_prime?(i)
        i += 1
    end
    arr[-1]
end

def prime?(num)
    return false if num < 2
    (2...num).each { |fact| return false if num % fact == 0 }
    true
end

def mersenne_prime?(num)
    return false if !prime?(num)
    if powOfTwo?(num + 1)
        true
    else
        false
    end
end

def powOfTwo?(num)
    while num > 2
        return false if num.odd?
        num /= 2
    end
    true
end


# p mersenne_prime(1) # 3
# p mersenne_prime(2) # 7
# p mersenne_prime(3) # 31
# p mersenne_prime(4) # 127
# p mersenne_prime(6) # 131071




# A triangular number is a number of the form (i * (i + 1)) / 2 where i is some positive integer. Substituting i with increasing integers gives the triangular number sequence. The first five numbers of the triangular number sequence are 1, 3, 6, 10, 15.

# We can encode a word as a number by taking the sum of its letters based on their position in the alphabet. For example, we can encode "cat" as 24 because c is the 3rd of the alphabet, a is the 1st, and t is the 20th:

# 3 + 1 + 20 = 24

# Write a method triangular_word? that accepts a word as an argument and returns a boolean indicating whether or not that word's number encoding is a triangular number. You can assume that the argument contains lowercase letters.

def triangular_word?(word)
    num = word_to_num(word)
    triangular_num?(num)
end

def triangular_num?(num)
    return true if num == 1 || num == 3
    half = num/2
    (1..half).each do |n|
        return true if (n * (n+1)) / 2 == num
    end
    false
end

def word_to_num(word)
    letters = word.split("")
    alpha = ('a'..'z').to_a
    alpha.unshift(nil)
    letters.inject(0) do |acc, letter |
        alpha.each_with_index do |alpha_letter, idx|
            letter = idx if letter == alpha_letter
        end
        acc + letter
    end
end

# p triangular_word?('abc')       # true
# p triangular_word?('ba')        # true
# p triangular_word?('lovely')    # true
# p triangular_word?('question')  # true
# p triangular_word?('aa')        # false
# p triangular_word?('cd')        # false
# p triangular_word?('cat')       # false
# p triangular_word?('sink')      # false




# Write a method consecutive_collapse that accepts an array of numbers as an argument. The method should return a new array that results from continuously removing consecutive numbers that are adjacent in the array. If multiple adjacent pairs are consecutive numbers, remove the leftmost pair first.

def consecutive_collapse(arr)
    # debugger
    while consecutive?(arr)
        (0...arr.length-1).each do |idx|
            if (arr[idx] == arr[idx+1] - 1 || arr[idx] == arr[idx+1] +1)
                arr = arr.slice(0...idx) + arr.slice(idx+2...arr.length)
                break
            end
        end
    end
    arr
end

def consecutive?(arr)
    (0...arr.length-1).each do |idx|
        return true if arr[idx] == arr[idx+1] - 1 || arr[idx] == arr[idx+1] +1
    end
    false
end

# p consecutive_collapse([3, 4, 1])                     # [1]
# p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
# p consecutive_collapse([9, 8, 2])                     # [2]
# p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
# p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
# p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
# p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
# p consecutive_collapse([13, 11, 12, 12])              # []




# Write a method pretentious_primes that takes accepts an array and a number, n, as arguments. The method should return a new array where each element of the original array is replaced according to the following rules:

# when the number argument is positive, replace an element with the n-th nearest prime number that is greater than the element
# when the number argument is negative, replace an element with the n-th nearest prime number that is less than the element

def pretentious_primes(arr, num)
    arr.map { |original| pretentious_prime(original, num) }
end

def pretentious_prime(num, int)
    prime_arr = []
    if int > 0
        i = num + 1
        while prime_arr.length < int
            prime_arr << i if prime?(i)
            i += 1
        end
    elsif int < 0
        i = num - 1
        while prime_arr.length < -int
            prime_arr << i if prime?(i)
            return nil if i < 2
            i -= 1
        end
    end
    return prime_arr[-1]
end


# p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
# p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
# p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
# p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
# p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
# p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
# p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
# p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
# p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
# p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]