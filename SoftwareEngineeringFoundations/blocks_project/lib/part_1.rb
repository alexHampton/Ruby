require "byebug"
def select_even_nums(array)
    array.select(&:even?)
end


def reject_puppies(dogs)
    dogs.reject { |dog| dog["age"] <= 2 }
end

def count_positive_subarrays(array)
    array.count { |subarr| subarr.sum > 0 }
end

def aba_translate(word)
    vowels = "aeiou"
    arr = word.split("").map do |char|
        if vowels.include?(char)
            char + "b" + char
        else
            char
        end
    end
    arr.join("")
end

def aba_array(words)
    # debugger
    words.map { |word| aba_translate(word) }
end