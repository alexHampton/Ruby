class Player
    def get_move
        puts "enter a position with coordinates separated by a space like `4 7`"
        position = gets.chomp.split(" ").map(&:to_i)
    end
end
