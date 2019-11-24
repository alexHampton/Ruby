
class Board
    def initialize
        @grid = [
            ['_','_','_'],
            ['_','_','_'],
            ['_','_','_']
        ]
    end

    def valid?(position)
        return false if position[0] < 0 || position[0] > 2
        return false if position[1] < 0 || position[1] > 2
        true
    end

    def empty?(position)
        @grid[position[0]][position[1]] == '_'
    end

    def place_mark(position, mark)
        if self.valid?(position)
            if self.empty?(position)
                @grid[position[0]][position[1]] = mark
            else
                raise "That position is already taken."
            end
        else
            raise "That is not a position on the board."
        end
    end

    def print
        puts
        puts "Current board:"
        puts
        @grid.each do |row|
            p row
            puts
        end
        puts 
        return
    end

    def win_row?(mark)
        @grid.each do |row|
            return true if row.all? { |el| el == mark }
        end
        false
    end

    def win_col?(mark)
        (0..2).each do |idx|
            return true if @grid[0][idx] == mark && @grid[1][idx] == mark && @grid[2][idx] == mark
        end
        false
    end

    def win_diagonal?(mark)
        diagonal_one = []
        diagonal_two = []
        opposite = @grid.length-1
        (0..opposite).each do |space|
            diagonal_one << @grid[space][space]
            diagonal_two << @grid[space][opposite]
            opposite -= 1
        end
        if diagonal_one.all?(mark) || diagonal_two.all?(mark)
            return true
        end
        false
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.each do |row|
            return true if row.any?("_")
        end
        false
    end
end