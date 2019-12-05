class HumanPlayer
    def initialize(name = "Human Player")
        @name = name
    end

    def prompt
        puts "Please enter the position of the card you would like to flip (e.g., '2 3')"
    end

    def get_input(previous_pos)
        gets.chomp
    end

    def receive_revealed_card(pos, card_value)

    end
end