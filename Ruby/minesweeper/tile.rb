
class Tile
    attr_accessor :revealed, :bombed, :flagged, :symbol
    
    def initialize
        @bombed = false
        @flagged = false
        @revealed = false
        @symbol = "X"
    end

    def which_symbol 
        if self.flagged
            self.symbol = "F"
        elsif !self.revealed
            self.symbol = "X"
        elsif self.bombed
            self.symbol = "*"
        else
            self.symbol = "_"
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

    def neighbor_bomb_count

    end

end