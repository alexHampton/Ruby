require_relative 'piece'
require_relative 'module_slideable'

class Bishop < Piece
    include Slideable
    attr_reader :pos
    def initialize(color, board, pos)
        super
    end

    def move_dirs
        DIAGONAL_DIRS
    end


end


b = Bishop.new(:black, "board", [0,4])
p b.diagonal_dirs