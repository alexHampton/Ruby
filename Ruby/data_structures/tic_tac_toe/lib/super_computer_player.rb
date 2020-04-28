require 'byebug'
require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    #store nodes in case there isn't a winning node so that we don't need to iterate twice.
    not_losing_or_winning_nodes = []
    # iterate through children and choose winning node if any.
    node.children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      elsif !child.losing_node?(mark)
        not_losing_or_winning_nodes << child
      end
    end
    # if no winning node, return a non losing node which will prevent opponent from winning.
    if not_losing_or_winning_nodes.empty?
      raise "Something's wrong here..."
    else
      return not_losing_or_winning_nodes.first.prev_move_pos
    end

  end


  # # Better code:

  # # This will make it so the computer won't always choose the exact same 
  # # solution if more than one solution is available.
  # possible_moves = node.children.shuffle

  # # Use #find instead of an each block to easily wfind a winning node.
  # node = possible_moves.find { |child| child.winning_node?(mark) }

  # # If a winning node was found, node will not be nil, so this will return
  # # that winning node.
  # return node.prev_move_pos if node

  # # Continue if no winning node was found, and find a node that isn't 
  # # a losing node.
  # node = possible_moves.find { |child| !child.losing_node?(mark) }
  # # Again, return that node if node is not nil.
  # return node.prev_move_pos if node

  # # If only losing nodes remain, then something is wrong with the program.
  # # Raise an alarm
  # raise "Something's wrong here..." 



end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
