# Monkey-Patch Ruby's existing Array class to add your own custom methods
require "byebug"
class Array
  def span
    return nil if self.empty?
    self.max - self.min
  end

  def average
    return nil if self.empty?
    avg = self.sum / (self.length * 1.0)
    return avg
  end

  def median
    return nil if self.empty?
    if self.length.odd?
        mid_index = self.length / 2
        self.sort[mid_index]
    else
        mid_index = (self.length / 2)
        num2 = self.sort[mid_index]
        num1 = self.sort[mid_index - 1]
        (num1 + num2) / 2.0
    end
  end

  def counts
    count = Hash.new(0)
    self.each { |el| count[el] += 1 }
    count
  end

#   PART 2

  def my_count(value)
    counts = self.counts
    counts[value]
  end

  def my_index(value)
    self.each_with_index do |el,i|
        return i if el == value
    end
    nil
  end

  def my_uniq
    compare_array = []
    self.each do |el|
        if !compare_array.include?(el)
            compare_array << el
        end
    end
    compare_array
  end

  def my_transpose
    dimensions = self[0].length
    # debugger
    transposed_array = []
    dimensions.times { transposed_array << []}
    self.each_with_index do |row, row_num|
        row.each_with_index do |el, col_num|
            transposed_array[col_num] << el
        end
    end
    transposed_array 
  end

end