require 'byebug'
class Tile
    attr_accessor :revealed, :bombed, :flagged, :symbol, :neighbor_bomb_count
    
    def initialize
        @bombed = false
        @flagged = false
        @revealed = false
        @symbol = "X"
        @neighbor_bomb_count = 0
        
    end

    def which_symbol 
        if self.flagged
            self.symbol = "F"
        elsif !self.revealed
            self.symbol = "X"
        elsif self.bombed
            self.symbol = "*"
        elsif self.neighbor_bomb_count == 0
            self.symbol = "_"
        else
            self.symbol = self.neighbor_bomb_count.to_s

        # else
        #     self.symbol = "$"
        end
    end

    def add_bomb
        self.bombed = true
    end

    def flag
        self.flagged ? self.flagged = false : self.flagged = true
    end

    def reveal
        self.revealed = true
    end

    def neighbors

    end


end