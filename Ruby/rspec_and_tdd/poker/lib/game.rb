require_relative "deck"
require_relative "player"

class Game
    attr_reader :deck, :players, :pot
    attr_accessor :current_raise_amount
    def initialize
        @deck = Deck.new
        @players = Hash.new
        @pot = 0
        @current_raise_amount = 0
    end

    def run
        add_players
        until @players.count == 1
            @deck.shuffle!
            play_turn
        end
        puts "#{@players.keys[0]} is the winner with a pot of $#{@players.values[0].money}!"
        sleep(1)
        return        
    end

    def update_pot(player, amount)
        @players[player].money -= amount
        @pot += amount
    end

    def play_turn
        take_in_ante
        puts "The pot amount is #{@pot}."
        deal_out_cards #use deck method
        @players.values.each { |player| player.look_at_hand }
        place_bets # use player methods
        discard_cards #player method
        deal_new_cards # maybe same as deal_out_cards
        @players.values.each { |player| player.look_at_hand }
        place_bets

        
        show_hands
        remove_players_with_no_money

        # @players.values.each { |player| @deck.deal_cards(5) }

    end

    private

    def take_in_ante
        amount = 10
        @players.values.each do |player| 
            @pot += player.put_into_the_pot(amount)
            puts "#{player.name} has put in the ante."
            sleep(0.5)
        end
    end

    def deal_out_cards
        5.times do
            @players.values.each do |player|
                unless player.fold
                    dealt_card = @deck.deal_cards(1)
                    player.hand.update_hand(dealt_card)
                end
            end
        end
    end

    def place_bets
        @players.values.each do |player|  
            unless player.fold
                puts "#{player.name} has folded?: #{player.fold}"
                move = player.make_move
                case move
                when :F
                    player.folds
                    puts "#{player.name} has folded."
                when :R
                    begin
                        puts "Current amount is $#{@current_raise_amount}." if @current_raise_amount > 0
                        calls = @current_raise_amount > 0 ? " calls #{@current_raise_amount} and" : ""
                        puts "How much would you like to raise?"

                        amount = gets.chomp
                        raise NotValidAmount if amount.to_i <= 0
                        amount = amount.to_i
                        raise InsufficientFunds if amount > player.money
                        prev_amount = @current_raise_amount
                        @current_raise_amount += amount 
                        player.put_into_the_pot(@current_raise_amount)
                        player.raised_amount = @current_raise_amount 
                        calls =                      
                        puts "#{player.name}#{calls} raises $#{amount}."      
                        puts player.raised_amount
                    rescue => ex
                        puts ex.message
                        retry                    
                    end
                when :S
                    # if someone has raised....
                    if !player.fold && player.raised_amount < @current_raise_amount
                        call(player)
                    else # no one has raised. Move to the next player.
                        puts "#{player.name} sees."                    
                    end
                end
                sleep(1)
            end
            
        end
        @players.values.each do |player|
            puts "#{player.name} has folded?: #{player.fold}"
            if player.raised_amount < @current_raise_amount && !player.fold
                begin
                    puts "#{player.name}, would you like to (F)old or (C)all?"
                    move = gets.chomp.upcase
                    raise InvalidMove if (move != 'F' && move != 'C')
                    if move == "C"
                        call(player)
                        # puts "#{player.name} calls."
                    else
                        player.folds 
                        puts "#{player.name} folds."
                    end
                    
                rescue => ex
                    puts ex.message
                    retry
                end
                
            end
        end

        
    end

    def call(player)
        plus_amount = @current_raise_amount - player.raised_amount
        player.put_into_the_pot(plus_amount)
        player.raised_amount += plus_amount
        puts "#{player.name} sees and puts in $#{plus_amount}."
    end

    def discard_cards
        @players.values.each { |player| player.discard unless player.fold }
    end

    def deal_new_cards
        @players.values.each do |player|
            unless player.fold
                current_card_count = player.hand.cards.count
                num_of_cards_needed = 5 - current_card_count
                new_cards = @deck.deal_cards(num_of_cards_needed)
                player.hand.update_hand(new_cards)
            end
        end
    end

    def add_players
        starting_amount = 500
        name = nil
        until name == "NA"
            puts "New player, please input your name: "
            puts 
            name = gets.chomp.capitalize
            break if name.upcase == "NA"
            @players[name] = Player.new(name, starting_amount)
            puts "If no more players, please enter 'NA'"
        end
    end


end

class InsufficientFunds < StandardError
    def message
        "Error: You don't have enough money."
    end
end

class InvalidMove < StandardError
    def message
        "Error: That is an invalid move."
    end
end

class InvalidAmount < StandardError
    def message
        "Error: Please input a dollar amount (Ex. 20)."
    end
end

class PotHasBeenRaised < StandardError
    def message
        "Error: The pot has been raised"
    end
end

if $PROGRAM_NAME == __FILE__
    Game.new.run
end
# g = Game.new

# g.deck.shuffle!
# g.deck.cards.each do |card|
#     print card.value
#     print " "
# end

