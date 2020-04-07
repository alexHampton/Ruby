class Map
    # A map stores info in key-value pairs,
    # where the keys are always unique.
    # Implement using only arrays:

    attr_accessor :array

    def initialize
        @array = []
    end

    def set(key, value)
        if self.array.any? { |pair| pair[0] == key }
            self.array.each do |pair|
                if pair[0] == key
                    pair[1] = value
                end
            end
        else
            self.array.push([key, value])
        end
    end

    def get(key)
        self.array.each do |pair|
            if pair[0] == key
                return pair[1]
            end
        end
        nil
    end

    def delete(key)
        self.array.each_with_index do |pair, i|
            if pair[0] == key
                return self.array.slice!(i)
            end
        end
        nil
    end

    def show
        self.array
    end

end