class Piece
    attr_accessor :pos
    attr_reader :color, :board
    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
    end

    # this will be changed in each class for the pieces
    # should return an array of all possible moves
    def valid_moves
        moves.reject { |move| move_into_check?(move) }
    end

    def symbol
        :NA
    end

    def move_into_check?(end_pos)
        formatted_end_pos = end_pos.is_a?(String) ? @board.letter_to_pos(end_pos) : end_pos
        potential_board = @board.dup
        potential_board.move_piece!(self.pos, end_pos)
        potential_board.in_check?(@color)
    end

    
end