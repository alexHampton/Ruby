require "byebug"
# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
def least_common_multiple(num_1, num_2)
    if num_1 < num_2
        small_num, large_num = num_1, num_2
    else
        small_num, large_num = num_2, num_1
    end
    lcm = large_num
    while lcm % small_num != 0
        lcm += large_num
    end
    lcm
end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    bigram_hash = Hash.new(0)
    str.each_char.with_index do |char, idx|
        bigram_hash[char + str[idx+1]] += 1 if idx != str.length - 1
    end
    high_num = bigram_hash.values.max
    bigram_hash.key(high_num)
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        inverse_hash = Hash.new
        self.each do |k, v|
            inverse_hash[v] = k
        end
        inverse_hash
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        self.each.with_index do |el1, idx1|
            self.each.with_index do |el2, idx2|
                if idx2 > idx1
                    count += 1 if el1 + el2 == num
                end
            end
        end
        count
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)
        prc ||= Proc.new { |one, two| one <=> two }

        sorted = false

        while !sorted
            sorted = true
            (0...self.length - 1 ).each do |i|
                if prc.call(self[i], self[i + 1]) == 1
                    self[i], self[i+1] = self[i+1], self[i]
                    sorted = false
                end
            end
        end
        self
    end
end
