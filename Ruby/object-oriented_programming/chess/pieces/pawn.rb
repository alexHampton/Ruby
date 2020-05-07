require_relative 'piece'

class Pawn < Piece
    def initialize(color, board, pos)
        super
    end

    def symbol
        @color == :white ? "\u2659" : "\u265f"
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
        one_ahead, two_ahead = [x + forward_dir, y], [x + (forward_dir * 2), y]
        forward_steps = [one_ahead] if board[one_ahead].is_a?(NullPiece)
        forward_steps << two_ahead if at_start_row? && board[two_ahead].is_a?(NullPiece)
        forward_steps
    end

    def side_attacks
        x, y = self.pos[0], self.pos[1]
        possible_moves = [[x + forward_dir, y + 1], [x + forward_dir, y - 1]]
        possible_moves.reject! do |move|
            new_spot = self.board[move]
            new_spot.nil? || new_spot.color == self.color || new_spot.color == nil
        end
        possible_moves
    end
end