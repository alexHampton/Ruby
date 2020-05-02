require_relative 'piece'
require_relative 'module_stepable'

class Knight < Piece
    include Stepable
    def initialize(color, board, pos)
        super
    end

    def symbol
        :N
    end

    # return array of all possible moves without obstacles
    def move_difs
        x,y = self.pos[0], self.pos[1]
        moves = []
        moves.push([x-2, y-1], [x-2,y+1])
        moves.push([x+2, y-1], [x+2, y+1])
        moves.push([x-1, y-2], [x-1, y+2])
        moves.push([x+1, y-2], [x+1, y+2])
        moves
    end

end