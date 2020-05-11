class Array
    def my_uniq
        my_uniq = []
        self.each { |el| my_uniq << el if !my_uniq.include?(el) }
        my_uniq
    end

    def two_sum
        two_sum = []
        comp_idx = 0
        compared = self[comp_idx]
        while comp_idx < self.length - 1
            start_idx = comp_idx + 1
            (start_idx...self.length).each do |idx|
                if compared + self[idx] == 0
                    two_sum << [comp_idx, idx]
                end
            end
            comp_idx += 1
            compared = self[comp_idx]
        end
        two_sum
    end

    def my_tranpose
        num = self.length
        transposed = []
        (0...num).each do |matcher|
            col = []
            self.each do |rows|
                rows.each_with_index do |el, el_idx|
                    col << el if el_idx == matcher
                end
            end
            transposed << col
        end
        transposed
    end

    def stock_picker
        stocks = [self[0], self[1]]
        stock_days = stock
    end
end