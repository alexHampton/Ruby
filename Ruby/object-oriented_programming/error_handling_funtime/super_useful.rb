# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue ArgumentError
  puts "Error: Your input could not be converted to an integer."
  return nil
end

# PHASE 3

class CoffeeError < StandardError
  def message
    "That's not a fruit, but I do like coffee."
  end
end

class NoFruitError < StandardError
  def message
    "I don't know that fruit..."
  end
end
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise NoFruitError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError => ex
    puts ex.message
    retry
  rescue => ex
    puts ex.message    
  end
   
end  

# PHASE 4

class ShortFriendshipError < StandardError
  def message
    "Error: You must know someone for at least 5 years in order for them to be your best friend."
  end
end

class NoNameError < StandardError
  def message
    "Error: Your friend must have a name."
  end
end

class NoPastimeError < StandardError
  def message
    "Error: You must include a favorite pastime."
  end
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @fav_pastime = fav_pastime

    begin
      raise NoNameError if name.empty?
      raise ShortFriendshipError if yrs_known < 5
      raise NoPastimeError if fav_pastime.empty?
      @name = name
      @yrs_known = yrs_known
      @fav_pastime = fav_pastime
    rescue => ex
      puts ex.message
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known} years. Let's be friends for another #{1000 * @yrs_known} years."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


