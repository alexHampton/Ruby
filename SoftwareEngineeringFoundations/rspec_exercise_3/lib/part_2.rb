def element_count(arr)
    count = Hash.new(0)
    arr.each { |el| count[el] += 1 }
    count
end

def char_replace!(str, hash)
    str.each_char.with_index do |char, idx|
        if hash.keys.include?(char)
            str[idx] = hash[char]
        end
    end
end

def product_inject(nums)
    nums.inject(:*)
end