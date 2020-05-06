require_relative 'piece'
require_relative 'module_slideable'

class Rook < Piece
    include Slideable
    attr_reader :pos
    def initialize(color, board, pos)
        super
    end

    def move_dirs
        HORIZONTAL_DIRS
    end

    def symbol
        @color == :white ? "\u2656" : "\u265c"
    end
end