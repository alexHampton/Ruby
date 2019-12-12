#Problem 1: 

def sum_recur(array)
    return 0 if array.length < 1
    array.first + sum_recur(array[1..-1])
end

#Problem 2: 

def includes?(array, target)
    return true if array.first == target
    return false if array.length < 1
    includes?(array[1..-1], target)
end

# Problem 3: 

def num_occur(array, target)
    return 0 if array.length < 1

    count = 0
    count += 1 if array.first == target
    count + num_occur(array[1..-1], target)
end

# Problem 4: 

def add_to_twelve?(array)
    return false if array.length < 2
    return true if array.first + array[1] == 12
    add_to_twelve?(array[1..-1])
end

# Problem 5: 

def sorted?(array)
    return true if array.length < 3
    return false if (array.first < array[1] && array[1] > array[2]) || (array.first > array[1] && array[1] < array[2])
    sorted?(array[1..-1])
end

# Problem 6: 

def reverse(string)
    return string if string.length == 0
    reverse(string[1..-1]) + string[0]
end
