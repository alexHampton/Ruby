require_relative 'poly_tree'

class KnightPathFinder
    attr_reader :root_node

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]

        def build_move_tree
            start_pos = @root_node
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

    end

    # Will make an array of all possible moves from the pos. I think this should be a class method because regardless of the instance, the valid moves from any given position will always be the same from that position.
    def self.valid_moves(pos)
        valid_moves = []
        x,y = pos[0],pos[1]

        # Get upper positions
        if y >= 2
            if x >= 1
                upper_left = [x-1, y-2]
                valid_moves << upper_left
            end
            if  x < 7
                upper_right = [x+1, y-2]
                valid_moves << upper_right
            end
        end
        # Get lower positions
        if y <= 5
            if x >= 1
                lower_left = [x-1, y+2]
                valid_moves << lower_left
            end
            if x < 7
                lower_right = [x+1, y+2]
                valid_moves << lower_right
            end
        end
        # Get left positions
        if x >= 2
            if y >= 1
                left_upper = [x-2, y-1]
                valid_moves << left_upper
            end
            if y < 7
                left_lower = [x-2, y+1]
                valid_moves << left_lower
            end
        end
        #Get right positions
        if x <= 5
            if y >=1
                right_upper = [x+2, y-1]
                valid_moves << right_upper
            end
            if y < 7
                right_lower = [x+2, y+1]
                valid_moves << right_lower
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
    
end


k = KnightPathFinder.new([0,0])

# parent = k.build_move_tree

# cren = []
# k.build_move_tree.children.each { |child| cren << child}

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
