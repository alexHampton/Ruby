class Item
    attr_accessor :title, :description
    attr_reader :deadline

    def self.valid_date?(date_string)
        # YYYY-MM-DD
        if date_string.length != 10
            return false
        else
            nums = date_string.split('-')
            year, month, day = nums[0], nums[1], nums[2]
            if year.length != 4 || month.length != 2 || day.length != 2
                return false
            else
                year, month, day = year.to_i, month.to_i, day.to_i
                if month < 1 || month > 12
                    return false
                elsif day <1 || day > 31
                    return false
                else
                    return true
                end
            end           
        end
    end

    def initialize(title, deadline, description)
        @title = title
        if Item.valid_date?(deadline)
            @deadline = deadline
        else
            raise 'Please enter a date for the deadline in the format of `YYYY-MM-DD`'
        end
        @description = description
        @done = false
    end

    def done
        @done
    end

    def deadline=(new_deadline)
        if self.valid_date?(new_deadline)
            @deadline = new_deadline
        else
            raise 'Please enter a date for the deadline in the format of `YYYY-MM-DD`'
        end
    end

    def toggle
        if @done
            @done = false
        else
            @done = true
        end
    end

    
end