require 'colorize'

class Tile
    attr_reader :value
    def initialize(value)
        @value = value.to_i
        @given = value == 0 ? false : true
    end

    def to_s
        if @given
            @value.to_s.colorize(:red)
        elsif @value == 0
            " "
        else
            @value.to_s
        end

    end

    def update_value(num)
        if @given
            puts "cannot change a given value."
        else
            @value = num
        end
    end

    def given?
        @given
    end
    

end