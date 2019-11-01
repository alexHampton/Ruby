class Code
  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(chars)
    chars.all? {|char| POSSIBLE_PEGS.has_key?(char.upcase)}
  end

  def self.random(number)
    selection = ["R","G","B","Y"]
    random_chars = []
    number.times { random_chars << POSSIBLE_PEGS.keys.sample }
    Code.new(random_chars)
  end

  def self.from_string(string)
    Code.new(string.split(""))
  end

  def initialize(chars)
    if Code.valid_pegs?(chars)
      @pegs = chars.map(&:upcase)
    else
      raise "Those are not valid chars"
    end
  end  

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    count = 0
    @pegs.each_with_index { |peg, i| count += 1 if guess[i] == peg}
    count
  end

  def num_near_matches(guess)
    count = 0
    @pegs.each_with_index do |peg, i|
      if guess[i] != peg
        count += 1 if @pegs.include?(guess[i])
      end
    end
    count
  end

  def ==(guess)
    @pegs == guess.pegs
  end

end

