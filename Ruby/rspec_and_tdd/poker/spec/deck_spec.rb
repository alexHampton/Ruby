require 'rspec'
require 'deck.rb'

describe 'Deck' do
    subject(:deck) { Deck.new }
    describe '#initialize' do
        it 'sets @cards to an array of cards' do
            expect(deck.cards[0].class).to eq(Card)
        end

        it 'makes a deck of 52 cards' do
            expect(deck.cards.length).to eq(52)
        end

        it 'contains only unique cards' do
            expect(deck.cards.uniq.length).to eq(52)
        end
    end

    describe "#shuffle!" do

        it "randomly shuffles the cards" do
            all_values = []
            deck.cards.each { |card| all_values << card.value }
            shuffled_values = []
            deck.shuffle!
            deck.cards.each { |card| shuffled_values << card.value }
            expect(all_values).not_to eq(shuffled_values)
        end

        it 'does not change the cards' do   
            all_values = []
            deck.cards.each { |card| all_values << card.value }
            shuffled_values = []
            deck.shuffle!
            deck.cards.each { |card| shuffled_values << card.value }         
            expect(all_values.sort).to eq(shuffled_values.sort)
        end
    end
end