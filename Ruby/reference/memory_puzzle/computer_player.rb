require_relative "./game.rb"
require_relative "./board.rb"

require 'byebug'

class ComputerPlayer
    attr_accessor :known_cards
    def initialize
        @grid_map = Board.new
        @unknown_positions = []
        # hash of card values as keys and array of positions as values.
        # ex: {"D"=>[[0,1],[2,3]], "B"=>[[2,2]]}
        @known_cards = Hash.new { |h, k| h[k] = []}
        @first_turn = true
        @first_guess_value = nil
        @second_guess_value = nil
        @first_pos = nil

        @grid_map.grid.each_with_index do |row, row_idx|
            @grid_map.size.times do 
                row << "X"
            end
            row.each_with_index do |col, col_idx|
                @unknown_positions << [row_idx, col_idx]
            end
        end

    end

    def first_guess
        guess = nil
        # In case the computer luckily guessed right, 
        # remove that guess from the known_cards hash
        # so it won't try to guess it again.
        if @first_guess_value == @second_guess_value
            @known_cards.reject! { |k, v| k == @first_guess_value }
        end
        if known_pairs?
            known_pairs = @known_cards.select { |k, v| v.length > 1 }

            #[0][1] to make sure it chooses the second of the two.
            guess = known_pairs.values[0][1]

            guess = position_to_string(guess)
        else
           guess = position_to_string(self.choose_random)
        end
    end

    def position_to_string(pos)
        pos.to_s[1] + pos.to_s[3..4]
    end

    def second_guess   
        if @known_cards[@first_guess_value].length > 1
            # if only one match, it chooses the only one there is.
            # if two matches, it will have already picked the second match '[0][1]'
            second_pair = @known_cards[@first_guess_value][0]
            # now that the computer successfully guessed a pair, remove the pair from the known_cards
            @known_cards.reject! { |card_value, positions| card_value == @first_guess_value }
            return position_to_string(second_pair)
        else
            position_to_string(self.choose_random)
        end            
    end

    def receive_revealed_card(pos, card_value)
        if @first_turn
            @first_guess_value = card_value
            @first_turn = false
        else
            @second_guess_value = card_value
            @first_turn = true
        end
        @unknown_positions.reject! { |p| p == pos }
        @known_cards[card_value] << pos
    end

    def choose_random
        total_unknown = @unknown_positions.length
        random_index = rand(total_unknown)
        return @unknown_positions[random_index]
    end

    def known_pairs?
        @known_cards.values.any? { |value| value.length > 1 }
    end

    def prompt
        
    end

    def get_input(previous_pos)
        if previous_pos.eql?(nil)
            self.first_guess
        else
            self.second_guess
        end
    end

end