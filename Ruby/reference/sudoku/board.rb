require_relative './tile.rb'
require 'byebug'

class Board

    attr_accessor :grid

    def initialize(file_name)
        @grid = Array.new(9) { Array.new(9) }
        File.readlines(file_name).each_with_index do |line, line_idx|
            line = line.chomp
            line.each_char.with_index do |num, num_idx|
                @grid[line_idx][num_idx] = Tile.new(num.to_i)
            end
        end
    end


    def render
        line = "  " + ("=" * 25)
        puts
        puts "    0 1 2   3 4 5    6 7 8 "
        puts line
        @grid.each.with_index do |row, row_idx|
            print "#{row_idx} "         
            row.each.with_index do |tile, idx|
                case idx
                when 0, 3, 6
                    print "| #{tile.to_s}"
                when 1, 4, 7
                    print " #{tile.to_s}"
                when 2, 5, 8
                    print " #{tile.to_s} "
                end
            end
            print "|"
            puts
            if row_idx == 2 || row_idx == 5 || row_idx == 8
                puts line
            end
        end
            return nil
    end

    def open_position?(row, col)
        !@grid[row][col].given?
    end

    def update_pos(row, col, num)
        @grid[row][col].update_value(num)
    end

    def solved?
        return self.squares_solved && self.rows_solved && self.cols_solved
    end

    def rows_solved
        @grid.each { |row| return false if !row_solved(row) }
        true
    end

    def cols_solved
        cols = @grid.transpose
        cols.each { |col| return false if !row_solved(col) }
        true
    end

    def squares_solved
        squares = self.squares_array
        squares.each { |square| return false if !row_solved(square) }
        true
    end

    def row_solved(row)
        row = row.map { |tile| tile.value }
        (1..9).each do |num|
            return false if !row.one?(num)
        end
        true

    end

    def squares_array
        arr = Array.new(9) { [] }
        arr_index = 0
        @grid.each_with_index do |row, row_idx|
            # debugger
            if row_idx == 0 || row_idx == 3 || row_idx == 6
                row.each_with_index do |tile, col_idx|
                    if col_idx == 0 || col_idx == 3 || col_idx == 6
                        # first row of square
                        arr[arr_index].push(@grid[row_idx][col_idx], @grid[row_idx][col_idx+ 1], @grid[row_idx][col_idx+2])
                        #second row of square
                        arr[arr_index].push(@grid[row_idx+1][col_idx], @grid[row_idx+1][col_idx+1], @grid[row_idx+1][col_idx+2])
                        # third row of square
                        arr[arr_index].push(@grid[row_idx+2][col_idx], @grid[row_idx+2][col_idx+1], @grid[row_idx+2][col_idx+2])

                        arr_index += 1
                    end
                end
            end
        end
        return arr
    end
    

end