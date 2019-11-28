class Player
    attr_accessor :letter_count
    attr_reader :name
    def initialize(name)
        @name = name
        @letter_count = 0
    end

    def letters
        case @letter_count
        when 0
            return " "
        when 1
            return "G"
        when 2
            return "GH"
        when 3
            return "GHO"
        when 4
            return "GHOS"
        when 5
            return "GHOST"
        else return "Error: Player's letter count is out of range."
        end
    end


end