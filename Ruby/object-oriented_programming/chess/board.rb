require_relative 'piece'
require_relative 'queen'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'king'
require_relative 'pawn'


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
        self.populate_board
        self[3,3] = Bishop.new(:black, self, [3,3])
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

    def populate_board
        @rows.each.with_index do |row, row_idx|
            if row_idx < 2
                color = :black
                row.each_with_index do |pos, pos_idx|
                    if row_idx == 0
                        self[row_idx, pos_idx] = Rook.new(color, self, [row_idx, pos_idx]) if pos_idx == 0 || pos_idx == 7
                        self[row_idx, pos_idx] = Knight.new(color, self, [row_idx, pos_idx]) if pos_idx == 1 || pos_idx == 6
                        self[row_idx, pos_idx] = Bishop.new(color, self, [row_idx, pos_idx]) if pos_idx == 2 || pos_idx == 5
                        self[row_idx, pos_idx] = Queen.new(color, self, [row_idx, pos_idx]) if pos_idx == 3
                        self[row_idx, pos_idx] = King.new(color, self, [row_idx, pos_idx]) if pos_idx == 4
                    else
                        self[row_idx, pos_idx] = Pawn.new(color, self, [row_idx, pos_idx])
                    end
                end
            elsif row_idx > 5
                color = :white
                row.each_with_index do |pos, pos_idx|
                    if row_idx == 7
                        self[row_idx, pos_idx] = Rook.new(color, self, [row_idx, pos_idx]) if pos_idx == 0 || pos_idx == 7
                        self[row_idx, pos_idx] = Knight.new(color, self, [row_idx, pos_idx]) if pos_idx == 1 || pos_idx == 6
                        self[row_idx, pos_idx] = Bishop.new(color, self, [row_idx, pos_idx]) if pos_idx == 2 || pos_idx == 5
                        self[row_idx, pos_idx] = Queen.new(color, self, [row_idx, pos_idx]) if pos_idx == 3
                        self[row_idx, pos_idx] = King.new(color, self, [row_idx, pos_idx]) if pos_idx == 4
                    else
                        self[row_idx, pos_idx] = Pawn.new(color, self, [row_idx, pos_idx])
                    end
                end

            end
        end
    end

    #used for testing purposes. will be moved later
    def render
        print "  0 1 2 3 4 5 6 7"
        puts
        i = 0
        while i < 8
            print i.to_s + " "
            @rows[i].each do |pos|
                if pos.nil?
                    print "O "
                else
                    print "#{pos.symbol} "
                end
            end

            puts
            i += 1
        end


    end
end

b = Board.new


b.render

p b[3,3].moves
puts
b[3,3].moves.each do |pos|
    spot = b[*pos]
    if spot.nil?
        p spot
    else
        p spot.color
        p " "
        p spot.symbol
    end
    puts
end


