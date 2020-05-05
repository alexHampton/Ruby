require 'colorize'
require_relative 'board'
require_relative 'pieces/null_piece'
require_relative'cursor'

require 'byebug'

class Display

    attr_reader :board
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end


    def render
    # set up some common variables    
        board_colors = [:magenta, :cyan]
        cursor_colors = [:blue, :white]
        selected_colors = [:blue, :black]
        valid_move_colors = [:red, :white]
    # print the top of the board
        print "  A B C D E F G H"
        puts
    # if cursor is selected, save an array of valid moves for the selected position
    
        current_pos = @board[*@cursor.cursor_pos]
        valid_moves = @cursor.selected ? current_pos.valid_moves : []
    # iterate through each position on each row of the board
        @board.rows.each_with_index do |current_row, row_idx|
            print (row_idx + 1).to_s + " "
            current_row.each_with_index do |position, col_idx|
                sign = position.is_a?(NullPiece) ? NullPiece.instance.symbol : position.symbol
                if valid_moves.include?([row_idx, col_idx])  # if the position is a valid move
                    # set the colors acordingly
                    print "#{sign} ".colorize(:color => valid_move_colors[0], :background => valid_move_colors[1])
                elsif @cursor.cursor_pos == [row_idx, col_idx]  # elsif position is the cursor position
                    print "#{sign} ".colorize(:color => cursor_colors[0], :background => cursor_colors[1]) if !@cursor.selected
                    print "#{sign} ".colorize(:color => selected_colors[0], :background => selected_colors[1]) if @cursor.selected
                else # bgnd color is boards color
                    if [row_idx, col_idx].all? { |coord| coord.odd? } || [row_idx, col_idx].all? { |coord| coord.even? }
                        print "#{sign} ".colorize(:color => position.color, :background => board_colors[0])
                    else
                        print "#{sign} ".colorize(:color => position.color, :background => board_colors[1])
                    end
                end
                
            end
            print " " + (row_idx + 1).to_s #print right side of the board
            puts            
        end
        puts "  A B C D E F G H" # print bottom of the board
    end

    def move_around
        system("clear")
        x = 0
        while x < 1

            render
            @cursor.get_input
            if @cursor.selected
                system("clear")
                render
                @board.request_move(@cursor.cursor_pos)
                @cursor.selected = false
            end
            if @board.checkmate?(:black) || @board.checkmate?(:white)
                puts "Oh damn, you lose"
                sleep(1)
            elsif @board.in_check?(:black) || @board.in_check?(:white)
                puts "The King is in check."
                sleep(1)
            end
            system("clear")
        end

    end

end

b = Board.new
d = Display.new(b)
puts d.render
print d.move_around