require "byebug"

def reverser(str, &prc)
    newStr = str.reverse
    prc.call(newStr)
end

def word_changer(sentence, &prc)
    words = sentence.split(" ")
    words = words.map {|word| prc.call(word) }
    words.join(" ")
end

def greater_proc_value(num, prc1, prc2)
    num1 = prc1.call(num)
    num2 = prc2.call(num)
    if num2 > num1
        num2
    else
        num1
    end
end

def and_selector(arr, prc1, prc2)
    arr.select { |el| prc1.call(el) }.select { |el| prc2.call(el) }
    # arr1 = arr.select {|el| prc1.call(el)}
    # finalArr = arr1.select { |el| prc2.call(el) }
end

def alternating_mapper(arr, prc1, prc2)
    arr.map.with_index do |el, idx|
        if idx.even?
            prc1.call(el)
        else
            prc2.call(el)
        end
    end
end