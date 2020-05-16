class Card
    attr_reader :value

    VALUES = %w(A 2 3 4 5 6 7 8 9 T J Q K)
    FACES = %w( H D C S)
    def initialize(value)
        raise "Value must be a string" if value.class != String
        raise "The value must have only two chars." if value.length != 2
        raise "The first char should be the card value (2-9, T, A, K, Q, J)" if !VALUES.include?(value[0].upcase)
        raise "The second char should be the face value (H, D, C, or S)" if !FACES.include?(value[1].upcase)
        @value = value
    end

    # "A returns 1 so it will have to be able to return 14 in certain cases"
    def numerical_value
        sign = @value[0]
        return Integer(sign) if sign.to_i > 0
        values = { "A" => 1, "T" => 10, "J" => 11, "Q" => 12, "K" => 13}
        values[sign]
    end

    def self.values
        VALUES
    end

    def self.faces
        FACES
    end



end