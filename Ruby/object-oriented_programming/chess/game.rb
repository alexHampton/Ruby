require_relative "display"
require_relative "player"


class Game

    attr_reader :board, :display, :players, :current_player
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @player1 = [HumanPlayer.new(:white, display), "Player 1"]
        @player2 = [HumanPlayer.new(:black, display), "Player 2"]
        @current_player = @player1
    end

    def play
        puts "Welcome to chess!"
        loop do
            system("clear")
            @display.render
            notify_players
            debugger
            @current_player[0].make_move
            swap_turn!
            # break if @board.checkmate?(@current_player[0].color)
            if @board.in_check?(@current_player[0].color) 
                puts "#{@current_player[1]}'s King is in check."
                sleep(1)
            end
        end
        swap_turn!
        puts "Checkmate. #{@current_player[1]} wins!"
    end

    def notify_players
        puts "It is #{@current_player[1]}'s turn"
    end

    def swap_turn!
        @current_player = current_player == @player1 ? @player2 : @player1
    end

end

if $PROGRAM_NAME == __FILE__
    Game.new.play
end