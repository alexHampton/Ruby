require "byebug"
#######################################################################
###                        GENERAL PROBLEMS                         ###
#######################################################################

# Write a method no_dupes?(arr) that accepts an array as an arg and 
# returns an new array containing the elements that were not repeated 
# in the array.

def no_dupes?(arr)
    count = Hash.new(0)
    arr.each { |el| count[el] += 1 }
    # count.keys.select { |el| count[el] == 1 }
    no_dupes = []
    count.each do |k, v|
        no_dupes << k if v == 1
    end
    no_dupes
end

# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []




# Write a method no_consecutive_repeats?(arr) that accepts an array 
# as an arg. The method should return true if an element never
# appears consecutively in the array; it should return false otherwise.

def no_consecutive_repeats?(arr)
    (0...arr.length - 1).each do |idx|
        return false if arr[idx] == arr[idx + 1]
    end
    true
end

# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true




# Write a method char_indices(str) that takes in a string as an arg. 
# The method should return a hash containing characters as keys.
# The value associated with each key should be an array containing
# the indices where that character is found.
def char_indices(str)
    indices = Hash.new() { |h,k| h[k] = [] }
    str.split("").each_with_index do |char, idx|
        indices[char] << idx
    end
    indices    
end

# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}




# Write a method longest_streak(str) that accepts a string as an arg.
# The method should return the longest streak of consecutive characters
# in the string. If there are any ties, return the streak that occurs
# later in the string.

def longest_streak(str)
    best_streak = ''
    current_streak = ''
    str.each_char.with_index do |char, idx|
        if current_streak.empty? || current_streak.include?(char)
            current_streak += char            
        else
            best_streak = current_streak if current_streak.length >= best_streak.length
            current_streak = char
        end
        best_streak = current_streak if idx == str.length - 1 && current_streak.length >= best_streak.length
    end
    best_streak

end

# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'




# Write a method bi_prime?(num) that accepts a number as an arg and
# returns a boolean indicating whether or not the number is a bi-prime.
# A bi-prime is a positive integer that can be obtained by multiplying
# two prime numbers.

def bi_prime?(num)
    all_factors = factors(num)
    all_factors.each do |factor_set|
        return true if prime?(factor_set[0]) && prime?(factor_set[1])
    end
    false
end

def factors(num)
    arr = []
    half = num / 2
    (1..half).each do |factor|
        if num % factor == 0
            pair = num / factor
            arr << [factor, pair]
        end
    end
    selected = []
    arr.each do |pair|
        sum = pair[0] + pair[1]
        if !selected.any? { |sel_pair| sel_pair[0] + sel_pair[1] == sum }
            selected << pair

        end
    end
    selected
end

def prime?(num)
    return false if num < 2
    (2...num).each do |factor|
        return false if num % factor == 0
    end
    return true
end

# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false




# A Vigenere Cipher is a Caesar cipher, but instead of a single key, a
# sequence of keys is used. For example, if we encrypt "bananasinpajamas"
# with the key sequence 1, 2, 3, then the result would be
#"ccqbpdtkqqcmbodt"

# Write a method vigenere_cipher(message, keys) that accepts a string
# and a key-sequence as args, returning the encrypted message. Assume
# that the message consists of only lowercase alphabetic characters.

def vigenere_cipher(message, keys)
    alpha = ('a'..'z').to_a
    encryption = ''
    count = 0
    message.each_char do |char|
        encr_index = (keys[count] + alpha.index(char)) % 26
        encryption += alpha[encr_index]
        count = (count + 1) % keys.length
    end
    encryption

end

# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"




# Write a method vowel_rotate(str) that accepts a string as an arg and
# returns the string where every vowel is replaced with the vowel the
# appears before it sequentially in the original string. The first
# vowel of the string should be replaced with the last vowel.

def vowel_rotate(str)
    vowels = 'aeiou'
    str_vowels = []
    str.each_char { |char| str_vowels. << char if vowels.include?(char) }
    str_vowels.unshift(str_vowels.pop)
    rotation = str.split("").map do |char|
        if vowels.include?(char)
            str_vowels.shift
        else
            char
        end
    end
    rotation.join("")
end

p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"




#######################################################################
###                           PROC PROBLEMS                         ###
#######################################################################


class String
    def select(&prc)
        return "" if !prc
        selected = ""
        self.each_char do |char|
            selected += char if prc.call(char)
        end
        selected
    end

    def map!(&prc)
        self.each_char.with_index do |char, idx|
            self[idx] = prc.call(char, idx)
        end
        self
    end
end


# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"



#######################################################################
###                        RECURSION PROBLEMS                       ###
#######################################################################


def multiply(a, b)
    if b > 0
        return a if b == 1
        a + (multiply(a, b - 1))
    elsif b < 0
        return -a if b == -1
        -a + (multiply(a, b + 1))
    else
        return 0
    end
end

# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(length)
    return [] if length == 0
    return [2] if length == 1
    return [2, 1] if length == 2
    return lucas_sequence(length - 1) + [lucas_sequence(length-1)[-1] + lucas_sequence(length-2)[-1]]
end

# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime_factorization(num)
    return [num] if prime?(num)
    (2...num).each do |factor|
        if prime?(factor) && num % factor == 0
            return [factor] + prime_factorization(num / factor)
        end
    end
end


# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]
