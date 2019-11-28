require 'byebug'

class Array
    # Enumerables

    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        selected = []
        self.my_each do |num|
            selected << num if prc.call(num)
        end
        selected
    end

    def my_reject(&prc)
        rejected = []
        self.my_each { |num| rejected << num if !prc.call(num) }
        rejected
    end

    def my_any?(&prc)
        self.my_each do |num|
            return true if prc.call(num)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |num|
            return false if !prc.call(num)
        end
        true
    end

    # Array

    def my_flatten
        flat = []
        self.each do |el|
            if el.is_a?(Array)
                flat.push(*el.my_flatten)
            else
                flat.push(el)
            end
        end
        flat
    end

    def my_zip(*args)
        zipped = Array.new(self.length) { [] }
        self.each_with_index { |el, idx| zipped[idx] << el }
        args.each do |arg|
            arg.each_with_index do |el, idx|
                zipped[idx] << el if zipped[idx] != nil
            end
        end
        zipped.each do |arr|
            while arr.length < args.length + 1
                arr << nil
            end
        end
        zipped
    end

    def my_rotate(num = 1)
        new_arr = []
        num = num % self.length
        (num...self.length).each { |idx| new_arr << self[idx] }
        (0...num).each { |idx| new_arr << self[idx] }
        new_arr
    end

    def my_join(separator = "")
        str = ""
        self.each { |el| str += el + separator } 
        str
    end

    def my_reverse
        i = -1
        reversed = []
        self.length.times do
            reversed << self[i]
            i -= 1
        end
        reversed
    end

end