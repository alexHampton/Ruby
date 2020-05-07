require_relative 'pieces/pieces.rb'
require 'byebug'

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

class MovedInCheck < StandardError
    def message 
        "Error: This places you in check."
    end
end

class Board
    attr_reader :rows
    def initialize
        @rows = Array.new(8) { Array.new(8)}
        self.populate_board
    end   

    def [](pos)
        return nil if pos[0] < 0 || pos[1] < 0
        @rows[pos[0]][pos[1]]
    end

    def []=(pos, piece)
        @rows[pos[0]][pos[1]] = piece
    end

    def move_piece(start_pos, end_pos)
        formatted_end_pos = end_pos.is_a?(String) ? letter_to_pos(end_pos) : end_pos
        sx, sy = start_pos
        begin
            raise NoPieceError if self[start_pos].nil?
            raise CannotMoveError if !self[start_pos].moves.include?(formatted_end_pos)
            raise MovedInCheck if self[start_pos].move_into_check?(formatted_end_pos)
            ex, ey = formatted_end_pos
            # Update the pos variable of the Piece moved
            self[start_pos].pos = [ex, ey]
            # Update the board to show the new position
            self[formatted_end_pos] = self[start_pos]
            # Remove the Piece from the statring position
            self[start_pos] = NullPiece.instance
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

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0,7) }
    end
   

    def request_move(start_pos)
        puts "Please select a place to move the selected piece. Ex: `f3`"
        new_move = gets.chomp
        formatted_end_pos = letter_to_pos(new_move)
        moves = [start_pos, formatted_end_pos]
        moves
    end

    def successful_move?(start_pos, end_pos)
        if self[start_pos].nil? || !self[start_pos].moves.include?(end_pos) || self[start_pos].move_into_check?(end_pos)
            return false
        end
        true
    end    

    def populate_board
        @rows.each.with_index do |row, row_idx|
            if row_idx < 2
                color = :black
                row.each_with_index do |pos, pos_idx|
                    if row_idx == 0
                        self[[row_idx, pos_idx]] = Rook.new(color, self, [row_idx, pos_idx]) if pos_idx == 0 || pos_idx == 7
                        self[[row_idx, pos_idx]] = Knight.new(color, self, [row_idx, pos_idx]) if pos_idx == 1 || pos_idx == 6
                        self[[row_idx, pos_idx]] = Bishop.new(color, self, [row_idx, pos_idx]) if pos_idx == 2 || pos_idx == 5
                        self[[row_idx, pos_idx]] = Queen.new(color, self, [row_idx, pos_idx]) if pos_idx == 3
                        self[[row_idx, pos_idx]] = King.new(color, self, [row_idx, pos_idx]) if pos_idx == 4
                    else
                        self[[row_idx, pos_idx]] = Pawn.new(color, self, [row_idx, pos_idx])
                    end
                end
            elsif row_idx > 5
                color = :white
                row.each_with_index do |pos, pos_idx|
                    if row_idx == 7
                        self[[row_idx, pos_idx]] = Rook.new(color, self, [row_idx, pos_idx]) if pos_idx == 0 || pos_idx == 7
                        self[[row_idx, pos_idx]] = Knight.new(color, self, [row_idx, pos_idx]) if pos_idx == 1 || pos_idx == 6
                        self[[row_idx, pos_idx]] = Bishop.new(color, self, [row_idx, pos_idx]) if pos_idx == 2 || pos_idx == 5
                        self[[row_idx, pos_idx]] = Queen.new(color, self, [row_idx, pos_idx]) if pos_idx == 3
                        self[[row_idx, pos_idx]] = King.new(color, self, [row_idx, pos_idx]) if pos_idx == 4
                    else
                        self[[row_idx, pos_idx]] = Pawn.new(color, self, [row_idx, pos_idx])
                    end
                end
            else
                row.each_with_index do |pos, pos_idx|
                    self[[row_idx, pos_idx]] = NullPiece.instance
                end
            end
        end
    end    

    def checkmate?(color)
        if in_check?(color)
            king_pos = find_king(color)
            king = self[king_pos]
            king_moves = king.valid_moves
            bad_guys = enemy_pieces(color)

            king_moves.each do |king_move|
                return false if bad_guys.none? { |bad_guy| bad_guy.moves.include?(king_move)}
            end
            return true
        end
        false
    end    

    def in_check?(color)
        king_pos = find_king(color)
        enemy_color = color == :black ? :white : :black
        bad_guys = enemy_pieces(color)
        bad_guys.any? { |piece| piece.moves.include?(king_pos)}
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

    def enemy_pieces(color)
        enemy_color = color == :black ? :white : :black
        pieces.select { |piece| piece.color == enemy_color }
    end

    # dup and move_piece! are used with the piece class to check if a move will put the king into check
    def dup
        new_board = Board.new
        @rows.each_with_index do |row, row_idx|
            row.each_with_index do |pos, col_idx|
                new_pos, new_piece_type, color = [row_idx, col_idx], pos.class, pos.color
                new_board[new_pos] = new_piece_type.new(color, new_board, new_pos) unless pos.is_a?(NullPiece)
                new_board[new_pos] = new_piece_type.instance if pos.is_a?(NullPiece)
            end
        end 
        new_board
    end

    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        old_pos = piece.pos
        piece.pos = end_pos
        self[end_pos] = piece
        self[start_pos] = NullPiece.instance
    end    
end
