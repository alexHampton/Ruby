def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(arr)
    arr.sum * 1.0 / arr.length
end

def repeat(str, num)
    str * num
end

def yell(str)
    str.upcase + "!"
end

def alternating_case(str)
    arr = str.split.map.with_index do |word, i|
        if i.even?
            word.upcase
        else
            word.downcase
        end
    end
    arr.join(" ")
end