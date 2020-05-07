module Stepable

    # takes move_difs from King/Knight and returns only the moves that are possible
    def moves
        moves = move_difs
        # reject moves that would be off the board
        moves.reject! {|move| move.any? {|num| num < 0 || num > 7 }}
        # reject moves where allies stand
        moves.reject! do |move|
            if !self.board[move].nil?
                self.board[move].color == self.color
            end
        end
        moves

    end

    private
    def move_difs
        
    end
end