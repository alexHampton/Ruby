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
        :Q
    end
end