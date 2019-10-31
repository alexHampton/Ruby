require "byebug"
def palindrome?(string)
    reversedString = ""
    string.each_char {|char| reversedString = char + reversedString }
    string == reversedString
end

def substrings(string)
    i = 0
    substringArray = []
    while i < string.length
        j = i
        while j < string.length
            substringArray << string[i..j]
            j += 1
        end
        i += 1
    end
    substringArray
end


def palindrome_substrings(string)
    debugger
    subs = substrings(string)
    finalArr = subs.select { |sub| sub.length > 1 && palindrome?(sub) }
    finalArr
end


puts palindrome_substrings("mississippi")
