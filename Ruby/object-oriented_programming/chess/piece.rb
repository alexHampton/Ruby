class Piece
    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
    end


    # this will be changed in each class for the pieces, 
    # using this to test exception handling in board class.
    def valid_move?
        true
    end
end