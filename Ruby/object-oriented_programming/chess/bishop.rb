require_relative 'piece'
require_relative 'module_slideable'

class Bishop < Piece
    include Slideable
    attr_reader :pos
    def initialize(color, board, pos)
        super
    end

    def symbol
        :B
    end

    def move_dirs
        DIAGONAL_DIRS
    end


end

