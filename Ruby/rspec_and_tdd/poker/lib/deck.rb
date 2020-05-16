require 'card'

class Deck
    attr_reader :cards
    def initialize
        @cards = create_deck
    end

    def shuffle!
        @cards.shuffle!
    end

    private
    def create_deck
        deck = []
        Card.faces.each do |face_value|
            Card.values.each do |value|
                deck << Card.new(value + face_value)
            end
        end
        deck
    end
end