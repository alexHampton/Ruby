require_relative 'poly_tree'

class KnightPathFinder
    attr_reader :root_node

    def initialize(pos)
        @considered_positions = [pos]
        def build_move_tree(pos)
            start_pos = PolyTreeNode.new(pos)
            queue = [start_pos]

            until queue.empty?
                current_node = queue.shift
                new_move_positions(current_node.value).each do |new_pos|
                    new_node = PolyTreeNode.new(new_pos)
                    current_node.add_child(new_node)
                    queue << new_node
                end
            end
            start_pos
        end
        @root_node = build_move_tree(pos)


    end

    # Will make an array of all possible moves from the pos. I think this should be a class method because regardless of the instance, the valid moves from any given position will always be the same from that position.
    def self.valid_moves(pos)
        current_x, current_y = pos
        valid_moves = []

        moves = [
            [-1, -2],
            [ 1, -2],
            [-1,  2],
            [ 1,  2],
            [-2, -1],
            [-2,  1],
            [ 2, -1],
            [ 2,  1]
        ]

        moves.each do |(x, y)|
            new_pos = [current_x + x, current_y + y]
            if new_pos.all? { |num| num.between?(0,7) }
                valid_moves << new_pos
            end
        end

        valid_moves
    end

    def new_move_positions(pos)
        all_moves = KnightPathFinder.valid_moves(pos)
        new_moves = all_moves.reject { |move| @considered_positions.include?(move) }
        new_moves.each {|move| @considered_positions << move }
        new_moves
    end

    def find_path(end_pos)
        end_node = @root_node.bfs(end_pos)
        trace_back_path(end_node)
    end

    def trace_back_path(end_node)
        path = [end_node.value]
        node = end_node
        until node == @root_node
            node = node.parent
            path.unshift(node.value)
        end
        path

    end
    
end


k = KnightPathFinder.new([0,0])

p k.find_path([7,6])
p k.find_path([6,2])


# cren = []
# k.root_node.children.each { |child| cren << child}

# gchildren = []
# cren.each { |child| child.children.each { |gchild| gchildren << gchild }}

# ggchildren = []
# gchildren.each {|gchild| gchild.children.each { |ggchild| ggchildren << ggchild }}

# gggchildren = []
# ggchildren.each { |ggchild| ggchild.children.each { |gggchild| gggchildren << gggchild }}

# ggggchildren = []
# gggchildren.each { |gggchild| gggchild.children.each { |ggggchild| ggggchildren << ggggchild }}
# ggggchildren.each { |ggggc| p ggggc.value }
# puts
# puts
# gggggchildren = []
# ggggchildren.each { |ggggchild| ggggchild.children.each { |gggggchild| gggggchildren << gggggchild }}
# gggggchildren.each { |gggggc| p gggggc.value }
