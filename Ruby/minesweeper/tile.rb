require 'colorize'
class Tile
    attr_accessor :revealed, :bombed, :flagged, :symbol, :neighbor_bomb_count
    
    def initialize
        @bombed = false
        @flagged = false
        @revealed = false
        @symbol = "X"
        @neighbor_bomb_count = nil
        
    end

    def which_symbol 
        if self.flagged
            self.symbol = "F".colorize(:green).on_yellow
        elsif !self.revealed
            self.symbol = "X".colorize(:black).on_white
        elsif self.bombed
            self.symbol = "*".colorize(:yellow).on_red
        elsif self.neighbor_bomb_count == 0
            self.symbol = "_".colorize(:green).on_cyan

        else
            self.symbol = self.neighbor_bomb_count.to_s
        end
    end

    def add_bomb
        self.bombed = true
    end

    def flag
        self.flagged = true
    end

    def unflag
        self.flagged = false
    end

    def reveal
        self.revealed = true
    end
end