class Hand
    attr_reader :cards
    def initialize(cards = [])
        @cards = cards
        @values = card_values
    end

    def high_card
        @values.max
    end

    def update_hand(cards)
        @cards += cards
        @values = card_values
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
        return "One Pair" if one_pair?
        "High Card"
    end

    # This will return an array of values of the hand rank.
    # The first unequal value to be compared will determine the winner:
    # Ex: [8, 4, 3] beats [7, 3, 9, 2, 3] because 8 is greater than 7.
    def hand_ranking_values
        rank_name = hand_ranking
        rank_values = []
        case rank_name
        when "Straight Flush"
            rank_values.push(8, high_card)
        when "Four of a Kind"
            rank_values.push(7, n_of_a_kind(@values)[0])
        when "Full House"
            biggest_match = n_of_a_kind(@values)
            triplet = biggest_match[0]
            remaining_vals = @values.reject { |val| val == triplet}
            doublet = n_of_a_kind(remaining_vals)[0]
            rank_values.push(6, triplet, doublet)
        when "Flush"
            rank_values << 5
            sorted = @values.sort
            rank_values << sorted.pop until sorted.empty?
        when "Straight"
            rank_values << 4
            sorted = @values.sort
            if sorted.max == 14 && sorted[-2] == 5
                rank_values << 5
            else
                rank_values << sorted.max
            end
        when "Three of a Kind"
            triplet = n_of_a_kind(@values)[0]
            remaining_vals = @values.reject { |val| val == triplet }
            high, low = remaining_vals.max, remaining_vals.min
            rank_values.push(3, triplet, high, low)
        when "Two Pair"
            big_match = n_of_a_kind(@values)[0]
            remaining_vals = @values.reject { |val| val == big_match }
            small_match = n_of_a_kind(remaining_vals)[0]
            last_card = remaining_vals.reject { |val| val == small_match }[0]
            rank_values.push(2, big_match, small_match, last_card)
        when "One Pair"
            match = n_of_a_kind(@values)[0]
            remaining_vals = @values.reject { |val| val == match }
            sorted_remaining_vals = remaining_vals.sort
            rank_values.push(1, match)
            rank_values.push(sorted_remaining_vals.pop) until sorted_remaining_vals.empty?
        when "High Card"
            sorted = @values.sort
            rank_values << 0
            rank_values.push(sorted.pop) until sorted.empty?
        else
            rank_values = ["This ain't right"]
        end

        rank_values
    end

    private

    def card_values
        @cards.map { |card| card.numerical_value }
    end

    def straight?
        best = high_card
        straight_builder = [best]
        (1..4).each do |n| 
            break unless @values.include?(best - n)
            straight_builder << (best - n)
        end
        return true if straight_builder.length == 5
        # extra step in case of low straight with Ace as 1.
        if best == 14
            least = 1
            straight_builder = [least]
            (1..4).each do |n|
                break unless @values.include?(least + n)
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
        best_match = []
        # iterate through each value
        vals.each_with_index do |val, idx|
            i = 0
            same = []
            # for each value, check and see if there are other matches
            (idx..vals.length-1).each do |comp_idx|
                i += 1 if vals[comp_idx] == val
                # store those matches in 'same' array
                same << vals[comp_idx] if vals[comp_idx] == val
            end

            # update the best match if there are more of a kind, or if the match is of a bigger rank.
            if (same.length > best_match.length) || (same.length == best_match.length && same[0] > best_match[0])
                best_match = same
            end
        end
        best_match
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
        false
    end

    # This can be used as is because it is only used after higher ranking 
    # matches are checked. Ex: If this was used before full_house?, then full
    # houses would be read as three of a kind.
    def three_of_a_kind?
        n_of_a_kind(@values).length == 3
    end

    
    def one_pair?
        n_of_a_kind(@values).length == 2
    end



end