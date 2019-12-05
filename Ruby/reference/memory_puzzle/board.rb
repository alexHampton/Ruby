require_relative "./card.rb"

class Board
    attr_reader :size, :grid
    def initialize(size = 4)
        @size = size
        @grid = Array.new(size) { [] }
    end

    def populate
        card_pairs = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
        deck = []
        card_pairs.each do |value|
            2.times { deck << Card.new(value) }
        end
        deck.shuffle!
        @grid.each do |row|
            @size.times { row << deck.shift }
        end

    end

    def [](pos)
        row, col = pos[0], pos[1]
        @grid[row][col]
    end

    def render
        puts "  | 0 | 1 | 2 | 3 |"
        puts "--|---------------|"
        @grid.each_with_index do |row, idx|
            print "#{idx} |"
            row.each do |card|
                print " #{card.display} |"
            end
            puts
        end
    end

    def won?
        @grid.all? { |row| row.all? { |card| card.face_up == true} }
    end

    def reveal(row, col)
        card = @grid[row][col]
        card.reveal
        card.value
    end

end