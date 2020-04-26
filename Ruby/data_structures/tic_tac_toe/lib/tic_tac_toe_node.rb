require 'byebug'

require_relative 'tic_tac_toe'



class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end


  def losing_node?(evaluator)
    if @board.tied?
      return false
    # if the opponent already won then return true
    elsif @board.over? && @board.winner != evaluator
      return true
    end
    # if it's the opponent's turn and any of the next moves will make the player lose return true
    if evaluator != self.next_mover_mark
      return true if self.children.any? { |child| child.losing_node?(evaluator)}
    # if all the next possible moves are losing moves, return true
    elsif evaluator == self.next_mover_mark
      return true if self.children.all? { |child| child.losing_node?(evaluator) }
    end
    false
  end

  def winning_node?(evaluator)

    if @board.over?
      return true if @board.winner == evaluator
      return false
    end
    
    if evaluator == self.next_mover_mark
      return true if self.children.any? { |child| child.winning_node?(evaluator)}
    elsif evaluator != self.next_mover_mark
      return true if self.children.all? { |child| child.winning_node?(evaluator)}
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  
  def children
    child_nodes = []
    (0..2).each do |row|
      (0..2).each do |col|
        if @board.empty?([row,col])
          new_board = @board.dup
          new_board[[row, col]] = @next_mover_mark
          new_mark = @next_mover_mark == :x ? :o : :x
          child = TicTacToeNode.new(new_board, new_mark, [row, col] )
          child_nodes << child
        end
      end
    end
    child_nodes
  end
end


# node = TicTacToeNode.new(Board.new, :x)
# p node
# p node.children.count