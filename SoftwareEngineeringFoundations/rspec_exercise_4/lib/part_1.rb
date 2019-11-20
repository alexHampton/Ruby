def my_reject(arr, &prc)
    new_arr = []
    arr.each { |el| new_arr << el if !prc.call(el)}
    new_arr
end

def my_one?(arr, &prc)
    count = 0
    arr.each do |el|
        count += 1 if prc.call(el)
        return false if count > 1
    end
    return true if count == 1
    false
end

def hash_select(hash, &prc)
    new_hash = {}
    hash.each { |k, v| new_hash[k] = v if prc.call(k, v) }
    new_hash
end

def xor_select(arr, prc1, prc2)
    arr.select do |el|
        (prc1.call(el) && !prc2.call(el)) || (!prc1.call(el) && prc2.call(el))
    end
end

def proc_count(val, procs)
    procs.count { |prc| prc.call(val) }
end