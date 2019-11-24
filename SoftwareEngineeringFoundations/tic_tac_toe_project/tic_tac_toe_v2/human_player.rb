class Human_player
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value.upcase
    end

    def get_position
        puts "Player #{@mark_value}, please input a number for the row, and a number for the column, ex. `0 2`"
        input = gets.chomp
        if input.split(" ").length != 2
            raise " Please ensure proper formatting of `row col`, Ex: `0 2`"
        else
            vals = input.split(" ")
            vals.map(&:to_i)
        end        
    end
end