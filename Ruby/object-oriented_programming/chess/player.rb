class Player
    attr_reader :color
    def initialize(color, display)
        @color = color
        @display = display
    end
end

class HumanPlayer < Player
    def initialize(color, display)
        super
    end

    def make_move
        puts "Please select a position"
        until @display.cursor.selected
            @display.cursor.get_input
            system("clear")
            @display.render
        end
        moves = nil
        # loop until the player makes a successful move
        loop do
            moves = @display.board.request_move(@display.cursor.cursor_pos)
            @display.cursor.selected = false
            break if @display.board.successful_move?(*moves)
        end
        end_move = moves[1]
        @display.board.move_piece(@display.cursor.cursor_pos, end_move)
    end
end