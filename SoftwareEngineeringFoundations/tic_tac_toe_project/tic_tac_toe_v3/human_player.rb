class HumanPlayer
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value.upcase
    end

    def get_position(legal_positions)
        valid = false

        while !valid
            puts "Player #{@mark_value}, please input a number for the row, and a number for the column, ex. `0 2`"
            input = gets.chomp
            vals = input.split(" ").map!(&:to_i)
            if vals.length != 2
                puts "Please ensure proper formatting of row and col, ex. `0 2`"
            elsif !legal_positions.include?(vals)
                puts "That is not a valid position."
            else
                valid = true
            end
        end
        vals     
    end
end