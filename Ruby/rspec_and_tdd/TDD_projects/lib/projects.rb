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
        biggest_win = 0
        biggest_diff = nil
        (0...self.length-1).each do |start_idx|
            (start_idx+1...self.length).each do |comp_idx|
                if self[comp_idx] - self[start_idx] > biggest_win
                    biggest_diff = [start_idx, comp_idx]
                    biggest_win = self[comp_idx] - self[start_idx]
                end                 
            end
        end
        biggest_diff
    end
end


class TowersOfHanoi
    attr_reader :pieces, :towers

    def initialize
        @pieces = [3,2,1]
        @towers = [[*@pieces], [],[]]
    end

    def render
        3.times { print "     |" }
        print "     "
        puts
        puts "     #{@towers[0][2].nil? ? '|' : @towers[0][2]}     #{@towers[1][2].nil? ? '|' : @towers[1][2]}     #{@towers[2][2].nil? ? '|' : @towers[2][2]}     "
        puts "     #{@towers[0][1].nil? ? '|' : @towers[0][1]}     #{@towers[1][1].nil? ? '|' : @towers[1][1]}     #{@towers[2][1].nil? ? '|' : @towers[2][1]}     "
        puts "     #{@towers[0][0].nil? ? '|' : @towers[0][0]}     #{@towers[1][0].nil? ? '|' : @towers[1][0]}     #{@towers[2][0].nil? ? '|' : @towers[2][0]}     "
        puts '======================='
        puts '     1     2     3     '
    end

    def play
        until won?
            render
            start_tower, end_tower = nil, nil
            until valid_move?(start_tower, end_tower)
                start_tower, end_tower = request_move
            end
            move(start_tower, end_tower)
        end
        puts 'You win!'       
        
    end

    def won?
        return true if @towers[0].empty? && @towers[1].empty?
        false
    end

    def request_move
        puts 'Please select a tower (1, 2, or 3)'
        start_tower = Integer(gets.chomp)
        puts 'Move to which tower? (1, 2, or 3)'
        end_tower = Integer(gets.chomp)
        [start_tower, end_tower]
    end

    def move(start_tower, end_tower)
        start_index, end_index = start_tower - 1, end_tower - 1
        moving_piece = @towers[start_index].pop
        @towers[end_index] << moving_piece
    end

    def valid_move?(start_tower, end_tower)
        return false if start_tower.nil? || end_tower.nil?
        start_index, end_index = start_tower - 1, end_tower - 1
        return false if @towers[start_index].empty? # invalid move if no pieces in starting tower.
        return true if @towers[end_index].empty? # valid move if ending tower is empty.
        return false if @towers[start_index].last > @towers[end_index].last # invalid move if top of starting tower is grater than top of ending tower.
        true # all else is valid.
    end

end