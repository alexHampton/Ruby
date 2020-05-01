module Slideable

    private
    HORIZONTAL_DIRS = [:horizontal, :vertical]
    DIAGONAL_DIRS = [:diag_one, :diag_two]


    public
    def moves
        moves = []
        if self.move_dirs.include?(:diag_one)
            moves += self.diagonal_dirs
        end
        if self.move_dirs.include?(:horizontal)
            moves += self.horizontal_dirs
        end
    end

    # Return an array of all diagonal moves from start position
    def diagonal_dirs
        moves = []
        x, y = self.pos[0], self.pos[1]
        up_y, down_y = y, y
        until x ==0
            x -= 1
            up_y -= 1
            down_y += 1
            moves.push([x, up_y], [x, down_y])
        end
        x = self.pos[0]
        up_y, down_y = y, y
        until x == 7
            x += 1
            up_y -= 1
            down_y += 1
            moves.push([x, up_y],[x, down_y])
        end
        # Reject the moves that would be off the chess board.
        moves.reject! { |pos| pos.any? { |num| num < 0 || num > 7}}
        moves
    end

    # Return and array of all horiz./ vert. moves from start pos
    def horizontal_dirs

    end

    
end