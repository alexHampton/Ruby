require_relative 'piece'

class Pawn < Piece
    def initialize(color, board, pos)
        super
    end

    def symbol
        :P
    end
end