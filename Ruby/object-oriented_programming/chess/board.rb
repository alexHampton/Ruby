require_relative 'piece'

class NoPieceError < StandardError
    def message
        "Error: There is no piece in the starting position."
    end
end

class CannotMoveError < StandardError
    def message 
        "Error: This piece is unable to move to that position."
    end
end

class Board
    attr_reader :rows
    def initialize
        @rows = Array.new(8) { Array.new(8)}
        (0..1).each do |row|
            (0..7).each do |pos|
                self.rows[row][pos] = Piece.new 
            end
        end
    end

    def move_piece(start_pos, end_pos)
        sx, sy = start_pos[0], start_pos[1]
        begin
            raise NoPieceError if self[sx, sy].nil?
            #Update this later when Piece types are added.
            raise CannotMoveError if !self[sx, sy].valid_move?
            ex, ey = end_pos[0], end_pos[1]
            self[ex, ey] = self[sx,sy]
            self[sx, sy] = nil
        rescue => ex
            puts ex.message
        end
    end

    def [](x, y)
        @rows[x][y]
    end

    def []=(x, y, piece)
        @rows[x][y] = piece
    end
end

b = Board.new

puts b.rows[0]
b.move_piece([5,2], [5,6])