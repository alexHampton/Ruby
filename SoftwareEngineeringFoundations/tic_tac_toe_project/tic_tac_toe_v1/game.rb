require_relative './board.rb'
require_relative './human_player.rb'

class Game

    def initialize(player_1_mark, player_2_mark)
        @player_1 = Human_player.new(player_1_mark)
        @player_2 = Human_player.new(player_2_mark)
        @board = Board.new
        @current_player = @player_1
    end

    def switch_turn
        if @current_player == @player_1
            @current_player = @player_2
        else
            @current_player = @player_1
        end
    end

    def play
        while @board.empty_positions?
            @board.print
            position = @current_player.get_position
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