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
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
