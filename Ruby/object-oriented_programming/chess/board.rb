require_relative 'piece'
require_relative 'queen'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'king'
require_relative 'pawn'
# require_relative 'null_piece'

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
    end

    def request_move(start_pos)
        puts "Please select a place to move the selected piece. Ex: `f3`"
        new_move = gets.chomp
        move_piece(start_pos, new_move)
    end


    def move_piece(start_pos, end_pos)
        formatted_end_pos = letter_to_pos(end_pos)
        sx, sy = start_pos
        begin
            raise NoPieceError if self[sx, sy].nil?
            #Update this later when Piece types are added.
            raise CannotMoveError if !self[sx, sy].valid_moves.include?(formatted_end_pos)
            ex, ey = formatted_end_pos
            # Update the pos variable of the Piece moved
            self[sx, sy].pos = [ex, ey]
            # Update the board to show the new position
            self[ex, ey] = self[sx,sy]
            # Remove the Piece from the statring position
            self[sx, sy] = NullPiece.instance
        rescue => ex
            puts ex.message
            sleep(1)
        end
    end

    def letter_to_pos(pos)
        letter, num = pos[0].upcase, (pos[1].to_i) - 1
        letters = "ABCDEFGH"
        numbered_pos = [num, letters.index(letter)]
        numbered_pos
    end

    def [](x, y)
        return nil if x < 0 || y < 0
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
            else
                row.each_with_index do |pos, pos_idx|
                    self[row_idx, pos_idx] = NullPiece.instance
                end
            end
        end
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0,7) }
    end

    def in_check?(color)
        king_pos = find_king(color)
        king_pos
        enemy_color = color == :black ? :white : :black
        enemy_pieces = pieces.select { |piece| piece.color == enemy_color }
        enemy_pieces.any? { |piece| piece.valid_moves.include?(king_pos)}
    end

    # returns an array of all positions of piece type and color
    def find_king(color)
        found_king = pieces.find { |piece| piece.is_a?(King) && piece.color == color}
        found_king.pos
    end

    def pieces
        pieces = []
        self.rows.each do |row|
            pieces += row.select { |pos| !pos.nil? }
        end
        pieces
    end
end