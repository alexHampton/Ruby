
class Stack
    attr_accessor :cs
    def initialize
        @cs = []
    end

    def push(el)
        self.cs.push(el)
    end

    def pop
        self.cs.pop
    end

    def peek
        self.cs.last
    end
end