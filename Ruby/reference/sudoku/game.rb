require_relative "./board.rb"

class Game
    attr_reader :board

    def initialize(file)
        @board = Board.new(file)
    end

    def run
        until @board.solved?
            self.play
        end
        puts "Congrats, you won!"
    end

    def play
        @board.render
        self.prompt

    end

    def prompt
        puts "Please enter a position, e.g. '0 5'"
        pos = gets.chomp
        row, col = pos[0].to_i, pos[2].to_i
        while !valid_pos(pos) || !@board.open_position?(row, col)
            if !valid_pos(pos)
                puts "Error: please enter two numbers, separated by a space. E.g. '4 9'"
                pos = gets.chomp
                row, col = pos[0].to_i, pos[2].to_i
            elsif !@board.open_position?(row, col)
                puts "Error: that position is already given. Please choose an unknown position."
                pos = gets.chomp
                row, col = pos[0].to_i, pos[2].to_i
            end
        end
        puts "Enter a value from 1 to 9."
        val = gets.chomp
        while !valid_value(val)
            puts "Error: please enter a number from 1 through 9 only."
            val = gets.chomp
        end
        val = val.to_i
        @board.update_pos(row, col, val)
    end

    def valid_pos(pos)
        regex = /^[0-8] [0-8]$/
        return pos.match?(regex)
    end

    def valid_value(val)
        regex = /^[1-9]$/
        return val.match?(regex)
    end
end


game = Game.new('sudoku1.txt')
game.run