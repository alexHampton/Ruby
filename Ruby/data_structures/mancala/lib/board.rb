class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1, @player2 = name1, name2
    @cups = Array.new(14) { Array.new }
    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each.with_index do |cup, idx|
      unless idx == 6 || idx == 13
        4.times { cup << :stone }
      end
    end
  end

  def valid_move?(start_pos)
    unless start_pos.between?(0,5) || start_pos.between?(7,12)
      raise 'Invalid starting cup'
    end
    if @cups[start_pos].empty?
      raise 'Starting cup is empty'
    end
    true
  end

  def make_move(start_pos, current_player_name)
    stone_count = @cups[start_pos].count
    @cups[start_pos] = []
    current_pos = start_pos + 1 % 14
    until stone_count == 0
      unless (current_player_name == @player1 && current_pos == 13) || 
             (current_player_name == @player2 && current_pos == 6)
        @cups[current_pos] << :stone
        stone_count -= 1
      end
      current_pos = (current_pos + 1) % 14 if stone_count > 0
    end
    self.render
    self.next_turn(current_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx

    # if ending_cup_idx is the players cup, return :prompt
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif @cups[ending_cup_idx].count == 1
      # if ending_cup_idx is on an empty cup, return :switch
      return :switch
    else
      # if ending_cup_idx is on a cup that has stones in it, return ending_cup_idx
      return ending_cup_idx 
    end
      
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? { |cup| cup.empty? } || 
    @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    side1, side2 = @cups[6], @cups[13]
    return :draw if side1.count == side2.count
    return @player1 if side1.count > side2.count
    @player2
  end
end
