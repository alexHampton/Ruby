class Card
    attr_reader :value, :face_up
    def initialize(value)
        @value = value
        @face_up = false
    end

    def display
        if @face_up
            @value
        else
            " "
        end
    end

    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end

    def ==(card)
        @value == card.value
    end

end