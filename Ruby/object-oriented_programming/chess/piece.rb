class Piece
    attr_accessor :pos
    attr_reader :color, :board
    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
    end

    # this will be changed in each class for the pieces
    # should return an array of all possible moves
    def valid_moves
        self.moves
    end

    def symbol
        :NA
    end
end