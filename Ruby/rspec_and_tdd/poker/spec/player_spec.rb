require 'rspec'
require 'player.rb'


describe 'Player' do
    subject(:player) { Player.new("Charles", 100)}
    let(:card1) {double("card", :value => "9C", :numerical_value => 9, :face_value => "C")}
    let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
    let(:card3) {double("card", :value => "JH", :numerical_value => 11, :face_value => "H")}
    let(:card4) {double("card", :value => "2S", :numerical_value => 2, :face_value => "S")}
    let(:card5) {double("card", :value => "AC", :numerical_value => 14, :face_value => "C")}
    let(:cards) { [card1, card2, card3, card4, card5] }    
    let(:hand) { double("hand", :cards => cards, :values => [9, 6, 11, 2, 14] )}


    describe "#initialize" do
        it "takes in a name, and initializes the variable" do
            expect(player.name).to eq("Charles")
        end

        it "takes in a money amount and initializes the variable" do
            expect(player.money).to eq(100)
        end

        it "initializes the hand to an instance of Hand" do
            expect(player.hand.class).to eq(Hand)
        end
    end

    describe "make_move" do
        context "when the player makes a valid move:" do
            it "returns the symbol of that move" do
                expect(player.make_move.class).to eq(Symbol)
            end
        end
    end

    describe "#discard" do

        # no idea how to write a test for something that gets user input...
        it "returns an array of the discarded cards" do
            # Use this to set the hand to the double
            player.instance_variable_set(:@hand, hand)
            values = cards.map { |card| card.value }
            discarded_cards = player.discard
            valid_cards = discarded_cards.all? { |card| values.include?(card) }
            expect(valid_cards).to be(true)
        end

        it "removes the discarded cards from the players hand" do
            # Use this to set the hand to the double
            player.instance_variable_set(:@hand, hand)
            puts
            puts
            puts "ONLY DISCARD ONE CARD TO PASS THIS TEST"
            puts
            player.discard
            expect(player.hand.cards.count).to eq(4)
        end

    end

end