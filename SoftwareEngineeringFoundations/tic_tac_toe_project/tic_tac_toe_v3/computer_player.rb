class ComputerPlayer
    attr_reader :mark_value
    
    def initialize(mark_value)
        @mark_value = mark_value.upcase
    end

    def get_position(legal_positions)
        rand_num = rand(legal_positions.length)
        position = legal_positions[rand_num]
        puts "#{@mark_value} chose position #{position}."
        position
    end
end