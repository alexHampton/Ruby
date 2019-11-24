require_relative './board.rb'
require_relative './human_player.rb'
require_relative './computer_player.rb'

class Game

    def initialize(n, player_marks)
        #player_marks is a hash containing marks as the keys, and booleans to represent (true)computer or (false)human.
        # {:X=>false, :Y=>true, :Z=>true}
        @board = Board.new(n)
        @players = []
        player_marks.each do |mark, comp|
            if comp
                @players << ComputerPlayer.new(mark)
            else
                @players << HumanPlayer.new(mark)
            end
        end
        @current_player = @players[0]
    end

    def switch_turn
        @players.rotate!
        @current_player = @players[0]
    end

    def play
        while @board.empty_positions?
            @board.print
            position = @current_player.get_position(@board.legal_positions)
            @board.place_mark(position, @current_player.mark_value)
            if @board.win?(@current_player.mark_value)
                @board.print
                puts "#{@current_player.mark_value} wins!"
                return
            end
            self.switch_turn
        end
        @board.print
        return "Draw"
    end
end