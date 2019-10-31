# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

# def compress_str(str)
#     newStr = ""
#     starting_index = 0
#     count = 0
#     (0..str.length - 1).each do |i|
#         if str[i] == str[starting_index]
#             count += 1
#         else
#             if count > 1
#                 newStr += count.to_s + str[starting_index]
#             else
#                 newStr += str[starting_index]
#             end            
#             starting_index = i
#             count = 1
#         end
#         if i == str.length - 1
#             if count > 1
#                 newStr += count.to_s + str[-1]
#             else
#                 newStr += str[-1]
#             end
#         end
#     end
#     newStr
# end

def compress_str(str)
    compressed = ""

    i = 0
    while i < str.length
        char = str[i]
        count = 0
        while char == str[i]
            count += 1
            i += 1
        end
        if count > 1
            compressed += count.to_s + char
        else
            compressed += char
        end
    end

    compressed
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
