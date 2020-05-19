require 'rspec'
require 'game.rb'

describe "Game" do
    subject(:game) { Game.new }
    describe "#initialize" do
        it "sets deck as an instance of the Deck class" do
            expect(game.deck.class).to eq(Deck)
        end

        it "initializes @players to an empty hash" do
            expect(game.players).to eq ({})
        end

        it "initializes @pot to 0" do
            expect(game.pot).to eq(0)
        end
    end

    describe "#update_pot" do
        # it "takes in a player and an amount as arguments" do
        #     expect {game.update_pot(player1, 50) }.to_not raise_error
        # end
    end
end