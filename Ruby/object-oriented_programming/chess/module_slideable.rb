module Slideable

    def moves
        moves = []
        if self.move_dirs.include?(:diag_one)
            moves += diagonal_dirs
        end
        if self.move_dirs.include?(:horizontal)
            moves += horizontal_dirs
        end
        moves
    end

    private
    HORIZONTAL_DIRS = [:horizontal, :vertical]
    DIAGONAL_DIRS = [:diag_one, :diag_two]

    # Return an array of all diagonal moves from start position
    def diagonal_dirs
        moves = []
        # Add moves toward the top left...
        moves += grow_unblocked_moves_in_dir(-1, -1)
        # ...the bottom left...
        moves += grow_unblocked_moves_in_dir(-1,  1)
        # ...the top right...
        moves += grow_unblocked_moves_in_dir( 1, -1)
        # ...and the bottom right.
        moves += grow_unblocked_moves_in_dir( 1,  1)       
        moves
    end

    # Return and array of all horiz./ vert. moves from start pos
    def horizontal_dirs
        moves = []
        # Add moves to the left...
        moves += grow_unblocked_moves_in_dir( 0, -1)
        # ...to the right...
        moves += grow_unblocked_moves_in_dir( 0,  1)
        # ...moves up...
        moves += grow_unblocked_moves_in_dir( 1,  0)
        # ...and moves down.
        moves += grow_unblocked_moves_in_dir(-1,  0) 
        moves
    end

    # dx and dy should be either +1, 0 or -1. This will be used to grow in all four directions 
    # for both diagonal and horizontal movement.
    # Ex. dx = -1, dy = -1 --> grow diagonally toward top left, or dx = 0, dy = 1 => grow horizontally toward the right.
    def grow_unblocked_moves_in_dir(dx, dy)
        sx, sy = self.pos[0], self.pos[1]
        ally_color = self.color
        enemy_color = self.color == :white ? :black : :white
        moves = []

        until (sx < 0 || sx > 7) || (sy < 0 || sy > 7)
            new_pos = [sx + dx, sy + dy]
            # stop adding moves if there is an ally piece in the position.
            # if !self.board[*new_pos].nil?
                break if !self.board[*new_pos].nil? && self.board[*new_pos].color == ally_color
            # end
            moves << new_pos
            # after adding the position, break if there was an enemy piece in the position.
            break if !self.board[*new_pos].nil?
            sx += dx
            sy += dy

        end
        # Reject the moves that would be off the chess board.
        moves.reject! { |pos| pos.any? { |num| num < 0 || num > 7}}
        moves
    end
    
end