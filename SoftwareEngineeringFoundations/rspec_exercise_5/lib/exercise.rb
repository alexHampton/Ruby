require "byebug"
def zip(*arrs)
    zipped = Array.new(arrs[0].length) { Array.new([])}
    arrs.each_with_index do |arr, i|
        arr.each_with_index do |el, i2|
            zipped[i2][i] = el
        end
    end
    zipped
end

def prizz_proc(arr, prc1, prc2)
    arr.select do |el|
        (prc1.call(el) && !prc2.call(el)) || (prc2.call(el) && !prc1.call(el))
    end
end

def zany_zip(*arrs)
    max_length = 0
    arrs.each { |arr| max_length = arr.length if arr.length > max_length }
    # debugger
    zipped = Array.new(max_length) { Array.new([]) }
    (max_length - 1).times do 
        zipped.each do |subarr|
            subarr << nil
        end
    end
    arrs.each_with_index do |arr, i|
        arr.each_with_index do |el, i2|
            zipped[i2][i] = el
        end
    end
    zipped

end

def maximum(arr, &prc)
    return nil if arr.empty?
    max_result = prc.call(arr[0])
    max_el = arr[0]
    arr.each { |el| max_el = el if prc.call(el) >= max_result }
    max_el
end

def my_group_by(arr, &prc)
    hash = Hash.new { |h, k| h[k] = [] }
    arr.each do |el|
        hash[prc.call(el)] << el
    end
    hash
end

def max_tie_breaker(arr, prc1, &prc2)
    # debugger
    max_arr = max_array(arr, prc2)
    return max_arr[0] if max_arr.length == 1
    final_arr = max_array(max_arr, prc1)
    final_arr[0]
end

def max_array(arr, prc)
    modified = arr.map { |el| prc.call(el) }
    max = modified.max
    arr.select { |el| prc.call(el) == max }
end

def silly_syllables(sent)
    words = sent.split(" ")
    words.map { |word| cutoff(word) }.join(" ")
end

def cutoff(word)
    vowels = "aeiou"
    vowel_indices = []
    word.each_char.with_index do |char, idx|
        vowel_indices << idx if vowels.include?(char)
    end
    return word if vowel_indices.length < 2
    start, finish = vowel_indices[0], vowel_indices[-1]
    return word[start..finish]
end
