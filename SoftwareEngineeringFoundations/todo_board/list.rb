require_relative './item.rb'

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = '')
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            return true
        else
            return false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        last = @items.length - 1
        if index < 0 || index > last
            return false
        end
        true
    end

    def swap(index_1, index_2)
        if !valid_index?(index_1) || !valid_index?(index_2)
            return false
        else
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        end
    end

    def [](index)
        @items[index]
    end

    def priority
        @items[0]
    end

    def print
        width = 80
        # HEADER WITH LABEL NAME
        puts "-" * width
        sides = (width / 2) - (@label.length / 2)
        puts (' '* sides) + @label.upcase + (' ' * sides)
        puts "-" * width

        # COLUMN NAMES
        col_1 = "Index "
        while col_1.length < (width * 0.10)
            col_1 += " "
        end
        col_2 = "| Item "
        while col_2.length < (width * 0.50)
            col_2 += " "
        end
        col_3 = "| Deadline "
        while col_3.length < (width * 0.30)
            col_3 += " "
        end
        col_4 = "| Done "
        while col_4.length < (width * 0.10)
            col_4 += " "
        end

        puts col_1 + col_2 + col_3 + col_4
        puts "-" * width

        # LIST ITEMS
        @items.each_with_index do |item, idx|
            index = idx.to_s
            while index.length < col_1.length
                index += " "
            end
            name = "| #{item.title} "
            while name.length < col_2.length
                name += " "
            end
            deadline = "| #{item.deadline} "
            while deadline.length < col_3.length
                deadline += " "
            end
            if item.done
                done = "| [X] "
            else
                done = "| [ ] "
            end
            while done.length < col_4.length
                done += " "
            end

            puts index + name + deadline + done
        end

        # BOTTOM BORDER
        puts "-" * width
        return
    end

    def print_full_item(index)
        if self.valid_index?(index)
            item = @items[index]
            width = 80
            puts "-" * width
            if item.done
                done = "    [X] "
            else
                done = "    [ ] "
            end
            space_size = width - item.title.length - item.deadline.length - done.length
            space_between = " " * space_size
            puts item.title + space_between + "#{item.deadline} #{done}" 
            puts item.description
            puts "-" * width
        else
            return false
        end        
    end

    def print_priority
        self.print_full_item(0)
    end

    def up(index, amount = 1)
        if self.valid_index?(index)
            amount.times do
                break if index == 0
                self.swap(index, index - 1)
                index -= 1
            end
        else
            return false
        end
        return true
    end

    def down(index, amount = 1)
        if self.valid_index?(index)
            amount.times do
                break if index == @items.length - 1
                self.swap(index, index + 1)
                index += 1
            end
        else
            return false
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        if index < 0 || index > @items.length - 1
            return false
        else
            @items = @items[0...index] + @items[index+1..-1]
        end
    end

    def purge
        @items.reject! { |item| item.done}
    end

end

# l = List.new("Groceries")
# l.add_item("apple", "2019-11-27", "fruit")
# l.add_item("banana", "2018-11-28", "fruit")
# l.add_item("watermelon", "2018-11-24", "fruit")
# l.add_item("mango", "2019-12-28", "fruit")
# l.add_item("carrot", "2018-03-28", "vegetable")
# l.add_item("onion", "2019-11-28", "vegetable")
# l.add_item("potato", "2017-12-28", "vegetable")
# l.add_item("broccoli", "2019-10-28", "vegetable")


