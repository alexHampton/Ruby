require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"

require 'byebug'

class Game
    def initialize(bool)
        case bool
        when true
            @player = ComputerPlayer.new
        when false
            @player = HumanPlayer.new
        end
        @board = Board.new
        @previous_guessed_pos = nil
        @move_count = 0
    end

    def play
        @board.populate
        until @board.won?
            system("clear")
            @board.render
            @player.prompt
            guessed_pos = @player.get_input(@previous_guessed_pos)
            valid_guess = self.check_validity(guessed_pos)                  
            arr = [valid_guess[0].to_i,valid_guess[2].to_i]
            self.make_guess(arr)
        end
        puts "Congratulations! you won in #{@move_count} moves!"
        self.reset
    end

    def reset
        @board = Board.new
        @previous_guessed_pos = nil
        @move_count = 0
        if @player.is_a?(ComputerPlayer)
            @player = ComputerPlayer.new
        else
            @player = HumanPlayer.new
        end
    end

    def make_guess(pos)
        current_guess = @board[pos]
        current_guess.reveal
        @player.receive_revealed_card(pos, current_guess.value)
        # if this is the first guess of a pair
        if @previous_guessed_pos.eql?(nil)
            #set this guess as the first guess of the pair
            @previous_guessed_pos = current_guess
        else
            system("clear")
            @board.render
            # if this guess is a match
            if @previous_guessed_pos == current_guess
                puts "It's a match!"
            else # this guess is not a match
                puts "Try again."
                @previous_guessed_pos.hide
                current_guess.hide
            end
            @previous_guessed_pos = nil
            @move_count += 1
            puts "Move count: #{@move_count}"
            # sleep(2)
        end
    end

    def check_validity(guessed_pos)
        while !valid_guess?(guessed_pos) || already_guessed?(guessed_pos)
            if !valid_guess?(guessed_pos)
                puts "Error: Please enter a position with a space between, like the example => '1 2'"
                puts "Make sure the numbers can be found on the grid."
            else
                puts "Error: That card has already been chosen. Please choose a different card."
            end
            guessed_pos = @player.get_input
        end   
        guessed_pos
    end

    def valid_guess?(guess)
        size = @board.size - 1
        regex = /^[0-#{size}] [0-#{size}]$/
        return guess.match?(regex)
    end

    def already_guessed?(guess)
        arr = [guess[0].to_i,guess[2].to_i]
        @board[arr].face_up
    end

end