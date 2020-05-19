require 'rspec'
require 'hand.rb'

describe Hand do
    let(:card1) {double("card", :value => "KC", :numerical_value => 13, :face_value => "C")}
    let(:card2) {double("card", :value => "QC", :numerical_value => 12, :face_value => "C")}
    let(:card3) {double("card", :value => "JC", :numerical_value => 11, :face_value => "C")}
    let(:card4) {double("card", :value => "TC", :numerical_value => 10, :face_value => "C")}
    let(:card5) {double("card", :value => "9C", :numerical_value => 9, :face_value => "C")}
    let(:cards) { [card1, card2, card3, card4, card5] }

    subject(:hand) { Hand.new(cards)}
    describe "#initialize" do
        it "takes in a hand of Cards and sets them as an array" do
            expect(hand.cards.class).to eq(Array)
        end

    end

    describe "#high_card" do
        it "gives the integer equivalent of the highest card in the hand" do
            expect(hand.high_card).to eq(13)
        end
    end


    describe "#hand_ranking" do
        context "when hand is a straight flush:" do
            let(:card1) {double("card", :value => "KC", :numerical_value => 13, :face_value => "C")}
            let(:card2) {double("card", :value => "QC", :numerical_value => 12, :face_value => "C")}
            let(:card3) {double("card", :value => "JC", :numerical_value => 11, :face_value => "C")}
            let(:card4) {double("card", :value => "TC", :numerical_value => 10, :face_value => "C")}
            let(:card5) {double("card", :value => "AC", :numerical_value => 14, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'Straight Flush'" do 
                allow(card1).to receive(:value).and_return("A")
                expect(hand.hand_ranking).to eq("Straight Flush")
            end
        end

        context "when hand is a low straight flush(A, 2, 3, 4, 5)" do
            let(:card1) {double("card", :value => "5C", :numerical_value => 5, :face_value => "C")}
            let(:card2) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:card3) {double("card", :value => "3C", :numerical_value => 3, :face_value => "C")}
            let(:card4) {double("card", :value => "2C", :numerical_value => 2, :face_value => "C")}
            let(:card5) {double("card", :value => "AC", :numerical_value => 14, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }

            it "still returns 'Straight Flush" do
                expect(hand.hand_ranking).to eq("Straight Flush")
            end
        end

        context "when hand is a four of a kind:" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "6H", :numerical_value => 6, :face_value => "H")}
            let(:card4) {double("card", :value => "6S", :numerical_value => 6, :face_value => "S")}
            let(:card5) {double("card", :value => "AC", :numerical_value => 14, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'Four of a kind'" do
                expect(hand.hand_ranking).to eq("Four of a Kind")
            end
        end

        context "when hand is a full house:" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "6H", :numerical_value => 6, :face_value => "H")}
            let(:card4) {double("card", :value => "4S", :numerical_value => 4, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'Full House'" do
                expect(hand.hand_ranking).to eq("Full House")
            end
        end

        context "when best hand is a flush:" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "3C", :numerical_value => 3, :face_value => "C")}
            let(:card3) {double("card", :value => "JC", :numerical_value => 11, :face_value => "C")}
            let(:card4) {double("card", :value => "7C", :numerical_value => 7, :face_value => "C")}
            let(:card5) {double("card", :value => "9C", :numerical_value => 9, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'Flush'" do
                expect(hand.hand_ranking).to eq("Flush")
            end
        end

        context "when best hand is a straight:" do
            let(:card1) {double("card", :value => "KC", :numerical_value => 13, :face_value => "C")}
            let(:card2) {double("card", :value => "QH", :numerical_value => 12, :face_value => "H")}
            let(:card3) {double("card", :value => "JC", :numerical_value => 11, :face_value => "C")}
            let(:card4) {double("card", :value => "TS", :numerical_value => 10, :face_value => "S")}
            let(:card5) {double("card", :value => "AC", :numerical_value => 14, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'Straight'" do
                expect(hand.hand_ranking).to eq("Straight")
            end
        end

        context "when best hand is a three of a kind" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "6H", :numerical_value => 6, :face_value => "H")}
            let(:card4) {double("card", :value => "7S", :numerical_value => 7, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'Three of a Kind'"do
                expect(hand.hand_ranking).to eq("Three of a Kind")
            end
        end

        context "when best hand is a two pair" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "7H", :numerical_value => 7, :face_value => "H")}
            let(:card4) {double("card", :value => "7S", :numerical_value => 7, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'Two Pair'"do
                expect(hand.hand_ranking).to eq("Two Pair")
            end
        end

        context "when best hand is a one pair" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "7H", :numerical_value => 7, :face_value => "H")}
            let(:card4) {double("card", :value => "9S", :numerical_value => 9, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'One Pair'"do
                expect(hand.hand_ranking).to eq("One Pair")
            end
        end

        context "when best hand is a high card" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "TD", :numerical_value => 10, :face_value => "D")}
            let(:card3) {double("card", :value => "7H", :numerical_value => 7, :face_value => "H")}
            let(:card4) {double("card", :value => "9S", :numerical_value => 9, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "returns 'High Card'"do
                expect(hand.hand_ranking).to eq("High Card")
            end
        end
        
    end




    describe "#hand_ranking_values" do
        it "returns an array showing the ranking of the hand in integer form" do
            expect(hand.hand_ranking_values.class).to eq(Array) 
        end

        context "when hand is a straight flush" do
            it "inserts an 8 for the hand, plus a number for the high card value" do
                expect(hand.hand_ranking_values).to eq([8, 13])
            end
        end

        context "when hand is a four of a kind" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "6H", :numerical_value => 6, :face_value => "H")}
            let(:card4) {double("card", :value => "6S", :numerical_value => 6, :face_value => "S")}
            let(:card5) {double("card", :value => "AC", :numerical_value => 14, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "inserts a 7 for the hand, plus a value for the matching number" do
                expect(hand.hand_ranking_values).to eq([7, 6])
            end
        end

        context "when hand is a full house" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "6H", :numerical_value => 6, :face_value => "H")}
            let(:card4) {double("card", :value => "4S", :numerical_value => 4, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "inserts a 6 for the hand, plus a value for the triplet,and for the pair" do
                expect(hand.hand_ranking_values).to eq([6, 6, 4])
            end
        end

        context "when hand is a flush" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "3C", :numerical_value => 3, :face_value => "C")}
            let(:card3) {double("card", :value => "JC", :numerical_value => 11, :face_value => "C")}
            let(:card4) {double("card", :value => "7C", :numerical_value => 7, :face_value => "C")}
            let(:card5) {double("card", :value => "9C", :numerical_value => 9, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "inserts a 5 for the hand, followed by a value for each card, high to low" do
                expect(hand.hand_ranking_values).to eq([5, 11, 9, 7, 6, 3])
            end
        end

        context "when hand is a straight" do
            let(:card1) {double("card", :value => "KC", :numerical_value => 13, :face_value => "C")}
            let(:card2) {double("card", :value => "QH", :numerical_value => 12, :face_value => "H")}
            let(:card3) {double("card", :value => "JC", :numerical_value => 11, :face_value => "C")}
            let(:card4) {double("card", :value => "TS", :numerical_value => 10, :face_value => "S")}
            let(:card5) {double("card", :value => "AC", :numerical_value => 14, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "inserts a 4 for the and, followed by the value of the highest card" do
                expect(hand.hand_ranking_values).to eq([4, 14])
            end
        end

        context "when hand is a low straight with an Ace" do
            let(:card1) {double("card", :value => "5C", :numerical_value => 5, :face_value => "C")}
            let(:card2) {double("card", :value => "4H", :numerical_value => 4, :face_value => "H")}
            let(:card3) {double("card", :value => "3C", :numerical_value => 3, :face_value => "C")}
            let(:card4) {double("card", :value => "2S", :numerical_value => 2, :face_value => "S")}
            let(:card5) {double("card", :value => "AC", :numerical_value => 14, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }

            it "sets 5 as the high card" do
                expect(hand.hand_ranking_values).to eq([4, 5])
            end
        end

        context "when hand is a 3 of a kind" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "6H", :numerical_value => 6, :face_value => "H")}
            let(:card4) {double("card", :value => "7S", :numerical_value => 7, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "inserts 3 for the hand, then the value of the triplet, and the ranks of the remaining cards" do
                expect(hand.hand_ranking_values).to eq([3, 6, 7, 4]) 
            end
        end

        context "when hand is a 2 pair" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "7H", :numerical_value => 7, :face_value => "H")}
            let(:card4) {double("card", :value => "7S", :numerical_value => 7, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "inserts 2 for the hand, then the rank of the high pair, the rank of the low pair, and the rank of the remaining card" do
                expect(hand.hand_ranking_values).to eq([2, 7, 6, 4])
            end
        end

        context "when hand is a 1 pair" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "6D", :numerical_value => 6, :face_value => "D")}
            let(:card3) {double("card", :value => "7H", :numerical_value => 7, :face_value => "H")}
            let(:card4) {double("card", :value => "9S", :numerical_value => 9, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "inserts 1 for the hand, then the pair rank, and the ranks of the ramaining cards in descending order" do
                expect(hand.hand_ranking_values).to eq([1, 6, 9, 7, 4]) 
            end
        end

        context "when hand is a high card" do
            let(:card1) {double("card", :value => "6C", :numerical_value => 6, :face_value => "C")}
            let(:card2) {double("card", :value => "TD", :numerical_value => 10, :face_value => "D")}
            let(:card3) {double("card", :value => "7H", :numerical_value => 7, :face_value => "H")}
            let(:card4) {double("card", :value => "9S", :numerical_value => 9, :face_value => "S")}
            let(:card5) {double("card", :value => "4C", :numerical_value => 4, :face_value => "C")}
            let(:cards) { [card1, card2, card3, card4, card5] }
            it "inserts a 0 for the hand, followed by the ranks of the cards in descending order" do
                expect(hand.hand_ranking_values).to eq([0, 10, 9, 7, 6, 4]) 
            end
        end
    end
end