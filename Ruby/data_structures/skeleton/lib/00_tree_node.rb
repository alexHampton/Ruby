require 'byebug'
class PolyTreeNode
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent
        @parent
    end

    def parent=(parent_node)
        if @parent != nil
            @parent.children.reject! { |child| child == self }
        end
        @parent = parent_node
        if @parent != nil
            @parent.children.push(self)
        end
    end

    def children
        @children
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "That is not a child of this node." if @children.none?(child_node)
        child_node.parent = nil
    end

    def value
        @value
    end

    def dfs(target_value)
        print self if @value == target_value
        return self if @value == target_value

        @children.each do |child|
            child.dfs(target_value)
        end

        puts self.value
    end

end


# n1 = PolyTreeNode.new(1)
# n2 = PolyTreeNode.new(2)
# n3 = PolyTreeNode.new(3)
# n4 = PolyTreeNode.new(4)
# n5 = PolyTreeNode.new(5)
# n6 = PolyTreeNode.new(6)

# n1.add_child(n2)
# n1.add_child(n3)
# n2.add_child(n4)
# n2.add_child(n5)
# n3.add_child(n6)

# #       n1
# #      /  \
# #    n2    n3
# #   / \   / 
# # n4  n5 n6 
# #

# n1.dfs(3)