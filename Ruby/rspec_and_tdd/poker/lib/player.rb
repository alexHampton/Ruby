require 'hand.rb'

class InvalidMove < StandardError
    def message
        "Error: Invalid option, please choose 'f', 's', or 'r' to fold, see, or raise, respectively"
    end
end

class InvalidCard < StandardError
    def message
        "Error: Invalid move. Please choose a card value or 'N'."
    end
end

class Player
    attr_reader :name, :money, :hand

    def initialize(name, money)
        @name = name
        @money = money
        @hand = nil
    end

    def update_hand(cards)
        @hand = Hand.new(cards)
    end

    def make_move
        begin
            puts "Would you like to (F)old, (S)ee, or (R)aise?"
            move = gets.chomp
            valid_moves = ['F', 'S', 'R']
            unless valid_moves.include?(move.upcase)
                raise InvalidMove
            end
            
        rescue => e
            puts e.message
            retry
        end
        
        return :F if move.upcase == "F"
        return :S if move.upcase == "S"
        return :R if move.upcase == "R"
    end

    def discard
        values = @hand.cards.map { |card| card.value }
        valid_moves = values + ['N']
        discarded_cards = []
        move = nil
        until move == 'N'
            print "Your hand: "
            values.each  { |card_value| print card_value + " "}
            puts
            print "Discarded cards: "
            discarded_cards.each { |dc| print dc + " "}
            puts
            puts "Please choose cards to discard by typing the card. "
            puts "If you want to keep a discarded card, please choose that card again."
            puts "If you don't want to discard any cards, please type 'N': "
            begin
                move = gets.chomp.upcase
                raise InvalidCard unless valid_moves.include?(move) || discarded_cards.include?(move)
            rescue => ex
                puts ex.message
                retry                
            end
            unless move == 'N'

                if valid_moves.include?(move)
                    # move the card to discarded cards
                    discarded_cards << move
                    values.reject! { |val| val == move }
                    valid_moves.reject! { |val| val == move }
                else # if the card has been selected to be discarded
                    # move it back to your hand
                    valid_moves << move
                    values << move
                    discarded_cards.reject! { |val| val == move }
                end
            end

        end
        @hand.cards.reject! { |card| discarded_cards.include?(card.value) }
        discarded_cards
    end

end

