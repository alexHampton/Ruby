def hipsterfy(word)
    vowels = "aeiou"
    revWord = word.reverse
    idx = nil
    revWord.each_char.with_index do |char, i|
        if vowels.include?(char)
            idx = i
            break
        end
    end
    return word if idx == nil
    (revWord[0...idx] + revWord[idx+1..-1]).reverse
end

def vowel_counts(str)
    vowels = "aeiou"
    hash = Hash.new(0)
    str.downcase.each_char do |char|
        if vowels.include?(char)
            hash[char] += 1
        end
    end
    hash
end

def caesar_cipher(str, n)
    alpha = ("a".."z").to_a
    code = ""
    str.each_char.with_index do |char, idx|
        if alpha.include?(char)
            currentIndex = alpha.index(char)
            char = alpha[(currentIndex + n) % 26]
        end
        code += char
    end
    code
end