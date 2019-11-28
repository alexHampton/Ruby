require 'byebug'

class AiPlayer
    attr_accessor :letter_count
    attr_reader :name
    def initialize(name= "Computer")
        @name = name
        @letter_count = 0
    end

    def letters
        case @letter_count
        when 0 
            return " "
        when 1
            return "G"
        when 2
            return "GH"
        when 3
            return "GHO"
        when 4
            return "GHOS"
        when 5
            return "GHOST"
        else return "Error: Player's letter count is out of range."
        end
    end

    def make_move(current_fragment, total_player_count, dictionary)
        # all letters of the alphabet.
        possible_letters = ("a".."z").to_a
        # all words in dictionary that start with the current fragment.
        possible_words = words_starting_with_string(current_fragment, dictionary)
        # letters that will make computer fail
        losing_letters = possible_letters.select { |move| possible_words.include?(current_fragment + move) }
        # remove losing letters from list off possible letters
        possible_letters.reject! { |move| losing_letters.include?(move) }

        #only select possible letters that can actually make a word when added to the current fragment
        possible_letters.select! do |char|
            new_frag = current_fragment + char
            new_possible_words = words_starting_with_string(new_frag, possible_words)
            new_possible_words.length > 0
        end
        winning_move = winning_moves(current_fragment, possible_letters, possible_words, total_player_count)

        # Computer will choose a winning move if possible
        if winning_move != nil
            return winning_move 
        # if no losing move, computer will choose any move.
        elsif possible_letters.length != 0
            random_idx = rand(possible_letters.length)
            return possible_letters[random_idx]
        # If no winning move, computer will intentionally choose a losing move.
        else losing_letters.length != 0
            random_idx = rand(losing_letters.length)
            return losing_letters[random_idx]
        end        

    end

    def winning_moves(current_fragment, possible_letters, possible_words, total_player_count)
        winning_moves = possible_letters.select do |move|
            new_fragment = current_fragment + move
            new_word_length = new_fragment.length 
            possible_words.all? { |word| word.length - new_word_length < total_player_count }
        end
        if winning_moves.length == 0
            return nil
        else
            random_idx = rand(winning_moves.length)
            winning_moves[random_idx]
        end        
    end

    def words_starting_with_string(str, dictionary)
        words = dictionary.dup
        str.each_char.with_index do |char, idx|
            words.select! { |word| word[idx] == char }
        end
        words
    end

end



# dic = Set.new
# File.readlines("dictionary.txt").each do |line|
#     dic << line.chomp
# end