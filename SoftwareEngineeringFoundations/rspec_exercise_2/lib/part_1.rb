def partition(arr, num) 
    divArr = [[],[]]
    arr.each do |arrNum|
        arrNum < num ? divArr[0] << arrNum : divArr[1] << arrNum
    end
    divArr
end

def merge(hash1, hash2)
    newHash = Hash.new()
    hash1.each { |k, v| newHash[k] = v }
    hash2.each { |k, v| newHash[k] = v }
    newHash
end

def censor(sent, arr)
    vowels = "aeiou"
    sentArr = sent.split(" ")
    censored = []
    sentArr.each do |word|
       if arr.include?(word.downcase)
            censoredWord = ""
            word.each_char do |char|
                    if vowels.include?(char.downcase)
                    censoredWord += "*"
                    else
                    censoredWord += char
                    end
            end
            censored << censoredWord
        else
            censored << word
        end
    end
    censored.join(" ")
end

def power_of_two?(num)
    i = num
    while i > 2
        return false if i.odd?
        i = i / 2
    end
    true
end