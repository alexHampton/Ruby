require 'byebug'

require 'set'
require_relative "./player.rb"
require_relative "./ai_player.rb"

class Game
    attr_reader :players, :current_player, :previous_player
    attr_accessor :fragment, :dictionary

    def initialize
        @players = []
        @current_player = nil
        @previous_player = nil
        @fragment = ""       
        @dictionary = Set.new
        File.readlines("dictionary.txt").each do |line|
            @dictionary << line.chomp
        end
    end
    
    def reset
        @players = []
        @current_player = nil
        @previous_player = nil
        @fragment = ""
    end

    def run
        self.setup
        lose_game = false
        while !lose_game
            return if !self.play_round
            if @current_player.letter_count == 5
                puts "#{@current_player.name} is eliminated!"
                next_player!
                remove_player(@previous_player)

                if @players.length == 1
                    puts "#{@current_player.name} wins!"
                    self.reset
                    lose_game = true
                end
            else
                next_player!
            end
        end
    end

    def setup
        puts "How many human-players?"
        human_player_count = gets.chomp.to_i

        (1..human_player_count).each do |num|
            puts "Enter the name of Player #{num.to_s}."
            name = gets.chomp
            @players << Player.new(name)            
        end
        puts "How many computer players?"
        computer_player_count = gets.chomp.to_i
        if computer_player_count > 0
            (1..computer_player_count).each do |num|
                name = "Computer #{num.to_s}"
                @players << AiPlayer.new(name)
            end
        end
        @current_player = @players[0]
        @previous_player = @players[-1]

    end

    def play_round
        puts
        puts "It is #{@current_player.name}'s turn. "
        puts "Current string: #{@fragment}"

        if @current_player.is_a?(Player)
            if !take_turn(@current_player)
                self.reset
                return false
            end
        else
            valid = false
            while !valid
                letter = @current_player.make_move(@fragment, @players.length, @dictionary)
                if valid_play(letter)
                    puts "#{@current_player.name} chooses #{letter}."
                    @fragment += letter
                    valid = true
                end
            end
        end
        
        if @dictionary.include?(@fragment)
            @current_player.letter_count += 1
            puts
            puts "The word is '#{@fragment}'!"
            puts "#{@current_player.name} now has #{@current_player.letters}."
            self.display_standings            
            @fragment = ""
        end
        true
    end

    def take_turn(player)
        valid_play = false
        while !valid_play
            puts "Please enter the next letter."
            puts
            input = gets.chomp
            return false if input == "quit"
            if valid_play(input)
                valid_play = true
                @fragment += input
            else
                puts "Sorry, that is not a valid entry."
                puts
            end
        end
        true
    end

    def remove_player(player)
        remove_index = @players.index(player)
        @players = @players[0...remove_index] + @players[remove_index+1..-1]
    end

    def display_standings
        width = 50
        half_scoreboard = 5
        puts
        puts ("-"*(width*0.5-half_scoreboard)) + "SCOREBOARD" + ("-"*(width * 0.5 - half_scoreboard))
        puts ("-" * width)
        half_width = width / 2
        player_space_sides = half_width - "PLAYERS".length
        letter_space_sides = half_width - "LETTERS".length
        player_space = (" " * (player_space_sides / 2)) + "PLAYER" + (" " * (player_space_sides / 2))
        letter_space = (" " * (letter_space_sides / 2)) + "LETTERS" + (" " * (  letter_space_sides / 2))
        puts player_space + letter_space
        puts ("-" * width)

        @players.each do |player|
            total_player_side = width / 2
            player_space = " " * ((total_player_side / 2) - (player.name.length / 2))
            player_side = player_space + player.name + player_space
            total_letter_side = width / 2
            letter_space = " " * ((total_letter_side / 2) - (player.letters.length / 2))
            letter_side = letter_space + player.letters + letter_space
            puts player_side + letter_side
        end
        puts
    end

     def next_player!
        current_player_index = self.players.index(@current_player)
        @previous_player = self.players[current_player_index]
        next_player_index = (current_player_index + 1) % @players.length
        @current_player = self.players[next_player_index]
    end    

    def valid_play(str)
        return false if !("a".."z").to_a.include?(str)
        potential_string = @fragment + str
        return false if words_starting_with_string(str, @dictionary).length < 1
        return false if @dictionary.none? { |word| word.include?(potential_string)}
        true
    end

    def words_starting_with_string(str, dictionary)
        words = dictionary.dup
        str.each_char.with_index do |char, idx|
            words.select! { |word| word[idx] == char }
        end
        words
    end

    
end