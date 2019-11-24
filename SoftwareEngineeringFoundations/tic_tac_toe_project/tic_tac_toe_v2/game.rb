require_relative './board.rb'
require_relative './human_player.rb'

class Game

    def initialize(n, *player_marks)
        @board = Board.new(n)
        @players = []
        player_marks.each do |player_mark|
            @players << Human_player.new(player_mark)            
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