require_relative 'piece'
require_relative 'module_stepable'
require 'byebug'

class King < Piece
    include Stepable
    def initialize(color, board, pos)
        super
    end

    def symbol
        :K
    end

    
    # return array of all positions piece could move to without obstacles
    def move_difs
        x,y = self.pos[0], pos[1]
        top_side, bottom_side = x-1, x+1
        left_side, right_side = y-1, y+1
        moves = []
        moves.push([top_side, left_side], [top_side, y], [top_side, right_side])
        moves.push([x, left_side], [x, right_side])
        moves.push([bottom_side, left_side],[bottom_side, y], [bottom_side, right_side])

        moves
    end
end