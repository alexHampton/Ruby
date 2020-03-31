require_relative 'tile'

class Board
    attr_reader :grid

    def initialize
        @grid = Array.new(9) do
            Array.new(9) { Tile.new }
        end

    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        self.grid.each.with_index do |row, idx|
            print "#{idx} "
            row.each.with_index do |tile, col_idx|
                # sym = tile.revealed ? "_" : "X"
                print "#{tile.which_symbol} "
            end
            puts
            
        end
        return
    end

    def run
        if self.lose?
            puts "You lose"
            return
        end
        until self.win?
            self.render
            puts "Please select a space (Ex: 0,0)."
        end
        puts "You win!"
        return
    end

    def win?
        
    end

    def lose?

    end

end

game = Board.new
game.run