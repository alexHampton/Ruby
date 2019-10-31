def my_map(arr, &prc)
    newArr = []
    arr.each {|n| newArr << prc.call(n)}
    newArr
end

def my_select(arr, &prc)
    newArr = []
    arr.each {|el| newArr << el if prc.call(el)}
    newArr
end

def my_count(arr, &prc)
    count = 0
    arr.each {|el| count += 1 if prc.call(el)}
    count
end

def my_any?(arr, &prc)
    arr.each { |el| return true if prc.call(el) }
    false
end

def my_all?(arr, &prc)
    arr.each { |el| return false if !prc.call(el) }
    true
end

def my_none?(arr, &prc)
    arr.each { |el| return false if prc.call(el) }
    true
end