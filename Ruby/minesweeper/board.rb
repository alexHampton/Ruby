require_relative 'tile'
require 'byebug'

class Board
    attr_reader :grid

    def initialize
        @grid = Array.new(9) do
            Array.new(9) { Tile.new }
        end


        10.times do
            x, y = rand(9), rand(9) #generate random numbers

            while @grid[x][y].bombed #if random position is already bombed
                x,y = rand(9), rand(9) #generate new random numbers
            end
            @grid[x][y].add_bomb #place bomb on random spot.

        end


    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        self.grid.each.with_index do |row, idx|
            print "#{idx} "
            row.each.with_index do |tile, col_idx|
                print "#{tile.which_symbol} "
            end
            puts
            
        end
        return
    end

    def run
        until self.win?
            
            self.render

            pos = false
            until self.valid_pos?(pos)
                pos = self.get_pos
            end
            val = false
            until self.valid_val?(val)
                val = self.get_val
            end
            self.update(pos[0], pos[1], val)

            if self.lose?(pos[0], pos[1], val)
                self.render
                puts "You hit a bomb. You lose."
                return
            end


        end
        puts "You win!"
        return
    end

    def update(pos_1, pos_2, val)
        tile = grid[pos_1][pos_2]
        if val == "F"
            tile.flag
        else
            tile.reveal
        end
    end

    def valid_pos?(pos)
        pos.is_a?(Array) && 
        pos.length == 2 && 
        pos.all? { |num| (0..8).include?(num) }
    end

    def valid_val?(val)
        val == "F" || val == "R"
    end

    def get_pos
        puts "Please select a position (Ex. '0,0')"
        pos = gets.chomp
        parse_pos(pos)
    end

    def get_val
        puts "Press 'R' to reveal, 'F' to flag."
        val = gets.chomp.upcase
    end

    def parse_pos(pos)
        begin
            pos.split(',').map { |num| Integer(num) }
        rescue => exception
            puts "Please input numbers only, separated by a comma."
        end
        
    end

    def win?
        
    end

    def lose?(x, y, val)
        return true if self.grid[x][y].bombed && val == 'R'
        false
    end

end

game = Board.new
game.run