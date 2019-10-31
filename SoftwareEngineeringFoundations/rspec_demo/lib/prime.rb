def prime?(num)
    return false if num < 2
    (2...num).each {|n| return false if num % n == 0 }
    true
end