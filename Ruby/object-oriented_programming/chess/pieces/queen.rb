require_relative 'piece'
require_relative 'module_slideable'

class Queen < Piece
    include Slideable
    attr_reader :pos
    def initialize(color, board, pos)
        super
    end

    def move_dirs
        HORIZONTAL_DIRS + DIAGONAL_DIRS
    end

    def symbol
        @color == :white ? "\u2655" : "\u265b"
    end
end