# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require "byebug"

def prime?(num)
    return false if num < 2
    (2...num).each { |n| return false if num % n == 0 } 
    true
end

def largest_prime_factor(num)
    # num.downto(2) { |factor| return factor if num % factor == 0 && prime?(factor) }
    arr = (2..num).select {|n| prime?(n)}
    divisorPrime = arr.select { |n| num % n == 0 }
    divisorPrime[-1]
end

def unique_chars?(string)
    compString = ""
    string.each_char do |char|
        compString += char if !compString.include?(char)
    end
    compString == string
end

def dupe_indices(array)
    hash = Hash.new { |h,k| h[k] = Array.new}
    # debugger
    array.each.with_index {|el, idx| hash[el].push(idx)}
    hash.select {|k, v| v.length > 1}
end

def ele_count(arr)
    count = Hash.new(0)
    arr.each { |ele| count[ele] += 1 }
    count
end

def ana_array(arr1, arr2)
    # debugger
    # hash1 = Hash.new(0)
    # hash2 = Hash.new(0)
    # arr1.each { |el| hash1[el] += 1}
    # arr2.each { |el| hash2[el] += 1}
    # hash1 == hash2
    ele_count(arr1) == ele_count(arr2)
end
