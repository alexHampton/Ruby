class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = Array.new

  end

  def play
    until @game_over
    take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if !@game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      STDOUT.print "\r#{color}"
      sleep 0.5
      STDOUT.print "\r       "
      sleep 0.5
    end
    puts
  end

  def require_sequence
    i = 0
    while i < @seq.length
      input = gets.chomp
      @game_over = input == @seq[i] ? false : true
      break if @game_over
      i += 1
    end

  end

  def add_random_color
    @seq << COLORS[rand(4)]
  end

  def round_success_message
    puts "Good job!"
    puts sequence_length.to_s
  end

  def game_over_message
    puts "You lose."
    puts "Your score was #{@sequence_length-1}."

  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = Array.new

  end
end


game = Simon.new
game.play