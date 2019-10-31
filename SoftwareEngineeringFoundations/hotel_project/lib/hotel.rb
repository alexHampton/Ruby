require "byebug"
require_relative "room"

class Hotel
    def initialize(name, rooms)
        # debugger
        @name = name
        @rooms = Hash.new()
        rooms.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end    
    end

    def name
        @name.split(" ").map { |word| word.capitalize }.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(name)
        # @rooms.keys.include?(name)
        @rooms.has_key?(name)
    end

    def check_in(person, room_name)
        if !self.room_exists?(room_name)
            puts "sorry, room does not exist"
        else
            if @rooms[room_name].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        end
    end

    def has_vacancy?
        @rooms.values.any? { |room| room.available_space > 0 }
        # total_rooms = 0
        # total_occupants = 0
        # @rooms.each do |k, v|
        #     total_rooms += v.capacity
        #     total_occupants += v.occupants.length
        # end
        # total_occupants < total_rooms
    end
    
    def list_rooms
        @rooms.each do |room_name, room|
            # puts "#{room_name} [#{room.available_space}]"
            print room_name + " "
            print room.available_space
            puts
        end
    end

end
