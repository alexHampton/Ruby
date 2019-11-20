def proper_factors(num)
    (1...num).select { |factor| num % factor == 0 }
end

def aliquot_sum(num)
    proper_factors(num).sum
end

def perfect_number?(num)
    aliquot_sum(num) == num
end

def ideal_numbers(n)
    arr = []
    current_n = 6
    while arr.length < n
        if perfect_number?(current_n)
            arr << current_n
        end
        current_n += 1
    end
    arr
end