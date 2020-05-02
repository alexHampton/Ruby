require_relative 'piece'

class Pawn < Piece
    def initialize(color, board, pos)
        super
    end

    def symbol
        :P
    end

    def moves
        moves = []
        moves.push(*forward_steps, *side_attacks)
        moves
    end

    private
    def at_start_row?
        if self.color == :white
            return true if self.pos[0] == 6
        else
            return true if self.pos[0] == 1
        end
        false
    end

    def forward_dir
        self.color == :white ? -1 : 1
    end

    # returns an array of the distance of forward steps
    # the pawn can take (1 and 2 if at start row)
    def forward_steps
        x, y = self.pos[0], self.pos[1]
        forward_steps = [[x + forward_dir, y]]
        if at_start_row?
            forward_steps << [x + (forward_dir * 2), y]
        end
        forward_steps
    end

    def side_attacks
        x, y = self.pos[0], self.pos[1]
        possible_moves = [[x + forward_dir, y + 1], [x + forward_dir, y - 1]]
        possible_moves.reject! do |move|
            self.board[*move].nil? || self.board[*move].color == self.color
        end
        possible_moves
    end
end