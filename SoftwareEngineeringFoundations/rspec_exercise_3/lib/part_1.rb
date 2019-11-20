def is_prime?(num)
    return false if num < 2
    (2...num).each {|factor| return false if num % factor == 0 }
    return true
end

def nth_prime(n)
    primes = []
    current_prime = 2
    while primes.length < n
        primes << current_prime
        current_prime += 1
        while !is_prime?(current_prime)
            current_prime += 1
        end
    end
    primes[-1]
end

def prime_range(min, max)
    (min..max).select { |num| is_prime?(num)}
end