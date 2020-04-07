class Queue
    attr_accessor :cq
    def initialize
        @cq = []
    end

    def enqueue(el)
        self.cq.push(el)
    end

    def dequeue
        self.cq.shift
    end

    def peek
        self.cq[0]
    end
end