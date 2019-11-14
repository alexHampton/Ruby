require "byebug"
class Board
    attr_reader :size

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
    end

    def [](position)
        row, column = position[0], position[1]
        @grid[row][column]
    end

    def []=(position, value)
        row, column = position[0], position[1]
        @grid[row][column] = value
    end

    def num_ships
        @grid.flatten.count { |space| space == :S }
    end

    def attack(position)
        if self[position] == :S
            self[position] = :H
            puts "you sunk my battleship!"
            true
        else
            self[position] = :X
            false
        end
    end

    def place_random_ships
        dimensions = @grid.length
        num = @grid.flatten.length / 4
        while num > 0
            randNum1 = rand(0...dimensions)
            randNum2 = rand(0...dimensions)
            if @grid[randNum1][randNum2] != :S
                @grid[randNum1][randNum2] = :S
                num -= 1
            end
        end
        ship_count = @grid.map { |row| row.count(:S) }.sum
    end

    def hidden_ships_grid
        dimensions = @grid.length
        hiddengrid = Array.new(dimensions) { Array.new(dimensions) }
        @grid.each_with_index do |row, row_index|
            row.each_with_index do |space, space_index|
                if space == :S
                    hiddengrid[row_index][space_index] = :N
                else
                    hiddengrid[row_index][space_index] = space
                end
            end
        end
        hiddengrid
    end

    def self.print_grid(grid)
        grid.each do |row|
            row.each_with_index do |space, idx|
                if idx != row.length - 1                    
                    print "#{space} "
                else
                    print "#{space}"
                end
            end
            puts
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
       Board.print_grid(self.hidden_ships_grid) 
    end
  
end