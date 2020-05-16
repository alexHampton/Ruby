require 'byebug'

class Hand
    attr_reader :cards
    def initialize(cards)
        @cards = cards
        @values = card_values
    end

    def high_card
        card_values.max
    end

    def hand_ranking
        if straight?
            return "Straight Flush" if flush?
            return "Straight"
        end
        return "Four of a Kind" if four_of_a_kind?
        return "Full House" if full_house?
        return "Flush" if flush?
        return "Three of a Kind" if three_of_a_kind?
        return "Two Pair" if two_pair?
        "No good"
    end

    private

    def card_values
        @cards.map { |card| card.numerical_value }
    end

    def straight?
        values = card_values
        best = high_card
        straight_builder = [best]
        (1..4).each do |n| 
            break unless values.include?(best - n)
            straight_builder << (best - n)
        end
        return true if straight_builder.length == 5
        # extra step in case of low straight with Ace as 1.
        if best == 14
            least = 1
            straight_builder = [least]
            (1..4).each do |n|
                break unless values.include?(least + n)
                straight_builder << (least + n)
            end
            return true if straight_builder.length ==5
        end
        false
    end

    def flush?
        faces = @cards.map { |card| card.face_value }
        faces.all? { |face| face == faces[0] }
    end

    # returns an array of the values that make up the biggest match.
    def n_of_a_kind(vals)
        same_vals = []
        vals.each_with_index do |val, idx|
            i = 0
            same = []
            (idx..vals.length-1).each do |comp_idx|
                i += 1 if vals[comp_idx] == val
                same << vals[comp_idx] if vals[comp_idx] == val
            end
            same_vals = same if same.length > same_vals.length
        end
        same_vals
    end

    def four_of_a_kind?
        n_of_a_kind(@values).length == 4
    end

    def full_house?
        biggest_match = n_of_a_kind(@values)
        return false unless biggest_match.length == 3
        removed_val = biggest_match[0]
        remaining_vals = @values.reject { |val| val == removed_val}
        return true if n_of_a_kind(remaining_vals).length == 2
        false
    end

    def two_pair?
        biggest_match = n_of_a_kind(@values)
        return false unless biggest_match.length == 2
        removed_val = biggest_match[0]
        remaining_vals = @values.reject { |val| val == removed_val }
        return true if n_of_a_kind(remaining_vals).length == 2
        # false
        true
    end

    def three_of_a_kind?
        n_of_a_kind(@values).length == 3
    end

    def one_pair?

    end

    def two_pair?

    end


end