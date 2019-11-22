require "byebug"
##########################################################################
###                             PHASE 1                                ###
##########################################################################

# Write a method duos that accepts a string as an argument and returns 
# the count of the number of times the same character appears 
# consecutively in the given string.

def duos(str)
    str.each_char.with_index.count { |char, idx| char == str[idx+1] }
end

# p duos('bootcamp')      # 1
# p duos('wxxyzz')        # 2
# p duos('hoooraay')      # 3
# p duos('dinosaurs')     # 0
# p duos('e')             # 0




# Write a method sentence_swap that accepts a sentence and a hash as 
# arguments. The method should return a new sentence where every word is 
# replaced with it's corresponding value in the hash. If a word does not 
# exist as a key of the hash, then it should remain unchanged.

def sentence_swap(sent, hash)
    words = sent.split(" ")
    words.map do |word|
        if hash.keys.include?(word)
            hash[word]
        else
            word
        end
    end
end

# p sentence_swap('anything you can do I can do',
#     'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
# ) # 'nothing you shall drink I shall drink'

# p sentence_swap('what a sad ad',
#     'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
# ) # 'make a happy ad'

# p sentence_swap('keep coding okay',
#     'coding'=>'running', 'kay'=>'pen'
# ) # 'keep running okay'




# Write a method hash_mapped that accepts a hash, a proc, and a block. 
# The method should return a new hash where each key is the result of the 
# original key when given to the block. Each value of the new hash should 
# be the result of the original values when passed into the proc.

def hash_mapped(hash, prc1, &prc2)
    new_hash = {}
    hash = hash.each do |k, v|
        new_hash[prc2.call(k)] = prc1.call(v)
    end
    new_hash
end

double = Proc.new { |n| n * 2 }
# p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

first = Proc.new { |a| a[0] }
# p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# {25=>"q", 36=>"w"}




# Write a method counted_characters that accepts a string as an argument. 
# The method should return an array containing the characters of the 
# string that appeared more than twice. The characters in the output 
# array should appear in the same order they occur in the input string.

def counted_characters(str)
    hash = Hash.new(0)
    arr = str.split("")
    arr.each do |char|
        hash[char] += 1
    end
    final_arr= []
    hash.each {|k, v| final_arr << k if v > 2}
    final_arr
end

# p counted_characters("that's alright folks") # ["t"]
# p counted_characters("mississippi") # ["i", "s"]
# p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
# p counted_characters("runtime") # []




# Write a method triplet_true? that accepts a string as an argument and 
# returns a boolean indicating whether or not the string contains three 
# of the same character consecutively.

def triplet_true?(str)
    last_checked_idx = str.length-3
    (0..last_checked_idx).each do |idx|
        return true if str[idx] == str[idx+1] && str[idx] == str[idx+2]
    end
    false
end

# p triplet_true?('caaabb')        # true
# p triplet_true?('terrrrrible')   # true
# p triplet_true?('runninggg')     # true
# p triplet_true?('bootcamp')      # false
# p triplet_true?('e')             # false




# Write a method energetic_encoding that accepts a string and a hash as 
# arguments. The method should return a new string where characters of 
# the original string are replaced with the corresponding values in the 
# hash. If a character is not a key of the hash, then it should be 
# replaced with a question mark ('?'). Space characters (' ') should 
# remain unchanged.

def energetic_encoding(str, hash)
    words = str.split(" ")

    words.each do |word|
        word.each_char.with_index do |char, char_idx|
            if hash.keys.include?(char)
                word[char_idx] = hash[char]
            else
                word[char_idx] = "?"
            end
        end
    end
    words.join(" ")
end

# p energetic_encoding('sent sea',
#     'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
# ) # 'zimp ziu'

# p energetic_encoding('cat',
#     'a'=>'o', 'c'=>'k'
# ) # 'ko?'

# p energetic_encoding('hello world',
#     'o'=>'i', 'l'=>'r', 'e'=>'a'
# ) # '?arri ?i?r?'

# p energetic_encoding('bike', {}) # '????'




# Write a method uncompress that accepts a string as an argument. The 
# string will be formatted so every letter is followed by a number. The 
# method should return an "uncompressed" version of the string where 
# every letter is repeated multiple times given based on the number that 
# appears directly after the letter.

def uncompress(str)
    new_str = ""
    str.each_char.with_index do |char, idx|
        if idx.odd?
            char.to_i.times { new_str += str[idx-1] }
        end
    end
    new_str
end

# p uncompress('a2b4c1') # 'aabbbbc'
# p uncompress('b1o2t1') # 'boot'
# p uncompress('x3y1x2z4') # 'xxxyxxzzzz'




##########################################################################
###                             PHASE 2                                ###
##########################################################################

# Write a method conjunct_select that accepts an array and one or more 
# procs as arguments. The method should return a new array containing the 
# elements that return true when passed into all of the given procs.

def conjunct_select(arr, *prcs)
    arr.select { |el| prcs.all? { |prc| prc.call(el) }}
end

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]




# Write a method convert_pig_latin that accepts a sentence as an 
# argument. The method should translate the sentence according to the 
# following rules:

# words that are shorter than 3 characters are unchanged
# words that are 3 characters or longer are translated according to the 
# following rules:

# if the word begins with a vowel, simply add 'yay' to the end of the 
# word (example: 'eat'->'eatyay')
# if the word begins with a non-vowel, move all letters that come before 
# the word's first vowel to the end of the word and add 'ay' (example: 
# 'trash'->'ashtray')
# Note that if words are capitalized in the original sentence, they 
# should remain capitalized in the translated sentence. Vowels are the 
# letters a, e, i, o, u.

def convert_pig_latin(sent)
    words = sent.split(' ')
    vowels = "aeiou"
    new_words = words.map do |word|
        if word.length < 3
            word
        elsif vowels.include?(word[0].downcase)
            word + 'yay'
        else
            # Find the index of the first vowel in the word
            first_vowel_idx = 0
            word.each_char.with_index do |char, char_idx|
                break if first_vowel_idx != 0
                if vowels.include?(char.downcase)
                    first_vowel_idx = char_idx
                end
            end

            # If the original word is capitalized, make the pig latin 
            # word capitalized
            new_word = word[first_vowel_idx..-1] + word[0...first_vowel_idx] + 'ay'
            if word[0] == word[0].downcase
                new_word
            else
                new_word.capitalize
            end            
        end
    end
    new_words.join(' ')
end

# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"




# Write a method reverberate that accepts a sentence as an argument. The 
# method should translate the sentence according to the following rules:

# words that are shorter than 3 characters are unchanged

# words that are 3 characters or longer are translated according to the following rules:
# if the word ends with a vowel, simply repeat the word twice (example: 
# 'like'->'likelike')
# if the word ends with a non-vowel, repeat all letters that come after 
# the word's last vowel, including the last vowel itself (example: 
# 'trash'->'trashash')
# Note that if words are capitalized in the original sentence, they 
# should remain capitalized in the translated sentence. Vowels are the 
# letters a, e, i, o, u.

def reverberate(sent)
    words = sent.split(" ")
    vowels = "aeiou"
    words.map do |word|
        if word.length < 3
            word
        elsif vowels.include?(word[-1].downcase)
            word + word.downcase
        else
            last_vowel_index = word.rindex(/[aeiou]/)
            word + word[last_vowel_index..-1].downcase
        end
    end.join(" ")
end

# p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
# p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
# p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
# p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"




# Write a method disjunct_select that accepts an array and one or more 
# procs as arguments. The method should return a new array containing the 
# elements that return true when passed into at least one of the given 
# procs.

def disjunct_select(arr, *prcs)
    arr.select { |el| prcs.any? { |prc| prc.call(el) }}
end

longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]




# Write a method alternating_vowel that accepts a sentence as an 
# argument. The method should return a new sentence where the words 
# alternate between having their first or last vowel removed. For example:

# the 1st word should be missing its first vowel
# the 2nd word should be missing its last vowel
# the 3rd word should be missing its first vowel
# the 4th word should be missing its last vowel
# ... and so on
# Note that words that contain no vowels should remain unchanged. Vowels 
# are the letters a, e, i, o, u.

def alternating_vowel(sent)
    # debugger
    words = sent.split(" ")
    vowels = "aeiou"
    words.map.with_index do |word, word_idx|
        if word.split("").none? { |char| vowels.include?(char) }
            word
        else
            if word_idx.even?
                vowel_idx = word.index(/[aeiou]/)
            else
                vowel_idx = word.rindex(/[aeiou]/)
            end
            word.slice(0...vowel_idx) + word.slice(vowel_idx+1..-1)
        end
    end.join(" ")
end

# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"




# Write a method silly_talk that accepts a sentence as an argument. The 
# method should translate each word of the sentence according to the 
# following rules:

# if the word ends with a vowel, simply repeat that vowel at the end of 
# the word (example: 'code'->'codee')
# if the word ends with a non-vowel, every vowel of the word should be 
# followed by 'b' and that same vowel (example: 'siren'->'sibireben')
# Note that if words are capitalized in the original sentence, they 
# should remain capitalized in the translated sentence. Vowels are the 
# letters a, e, i, o, u.

def silly_talk(sent)
    words = sent.split(" ")
    vowels = "aeiou"
    words.map do |word|
        if vowels.include?(word[-1])
            word + word[-1]
        else
            word_syllables = syllables(word)
            (0...word_syllables.length-1).each do |idx|
                word_syllables[idx] += "b" + word_syllables[idx][-1].downcase
            end
            word_syllables.join("")
        end
    end.join(" ")
end

def syllables(word)
    vowels = "aeiou"
    syllables = []
    beginning = 0
    word.each_char.with_index do |char, char_idx|
        if char_idx == word.length - 1
            syllables << word[beginning..char_idx]
        elsif vowels.include?(char.downcase)
            syllables << word[beginning..char_idx]
            beginning = char_idx + 1
        end
    end
    syllables
end

# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"




# Write a method compress that accepts a string as an argument. The 
# method should return a "compressed" version of the string where streaks 
# of consecutive letters are translated to a single appearance of the 
# letter followed by the number of times it appears in the streak. If a 
# letter does not form a streak (meaning that it appears alone), then do 
# not add a number after it.

def compress(str)
    beginning = 0
    count = 0
    new_str = ""
    (beginning...str.length).each do |idx|
        if str[idx] == str[beginning]
            count += 1 
        else
            new_str += str[beginning]
            new_str += count.to_s if count > 1
            beginning = idx
            count = 1
        end
        if idx == str.length - 1
            new_str += str[beginning] 
            new_str += count.to_s if count > 1
        end
    end
    new_str
end

# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"