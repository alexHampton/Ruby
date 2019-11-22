require_relative "./passenger.rb"

class Flight
    attr_reader :passengers

    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    def full?
        @passengers.length == @capacity 
    end

    def board_passenger(passenger)
        if self.full?
            return nil
        else
            if passenger.has_flight?(@flight_number)
                @passengers << passenger
            else
                return nil
            end
        end
    end

    def list_passengers
        @passengers.map { |pass| pass.name}
    end

    def [](index)
        @passengers[index]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end

end