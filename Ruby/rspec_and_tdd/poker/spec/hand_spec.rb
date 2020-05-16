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

        # context "when best hand is a one pair" do
        #     it "returns 'One Pair'"do
        #         expect(hand.hand_ranking).to eq("One Pair")
        #     end
        # end

        # context "when best hand is a high card" do
        #     it "returns 'High Card'"do
        #         expect(hand.hand_ranking).to eq("High Card")
        #     end
        # end
        
    end
end