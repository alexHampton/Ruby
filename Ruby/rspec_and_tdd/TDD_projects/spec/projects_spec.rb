require 'rspec'
require 'projects.rb'

describe Array do
    subject(:array) { Array.new }

    describe '#my_uniq' do
        let(:array) { [1,2,3,2,4,5,5] }

        it 'takes in an Array and returns a new array' do
            expect(array.my_uniq.class).to be(Array)
        end

        it 'contains every unique item of the original array' do
            expect(array.my_uniq).to include(1, 2, 3, 4, 5)
        end

        it 'has only one of each unique item' do 
            expect(array.my_uniq).to eq([1,2,3,4,5])
        end

    end

    describe '#two_sum' do
        context 'with no matching pairs whose sum equals 0' do
            let(:array) { [-2, 0, 1, 3] }

            it 'returns an empty array' do 
                expect(array.two_sum).to eq([])
            end
        end

        context 'with matching pairs whose sum equals 0' do
            let(:array) { [-2, -1, 0, 1, 2] }

            it 'returns a 2-dimensional array' do
                expect(array.two_sum.length).to eq(2)
                expect(array.two_sum.flatten.length).to eq(4)
            end

            it 'returns matching indexes' do
                expect(array.two_sum).to eq([ [0, 4], [1, 3] ])
            end

            it 'is sorted smaller index to bigger index' do
                expect([-1, -2, 2, 0, 1].two_sum).to eq([[0, 4], [1, 2]])
            end
        end
    end

    describe '#my_transpose' do
        subject(:array) {
            [
                [0,1,2],
                [3,4,5],
                [6,7,8]
            ]
        }

        it 'returns an array' do
            expect(array.my_tranpose.class).to eq(Array)
        end

        it 'has the same length as the original array' do
            expect(array.my_tranpose.length).to eq(3)
        end

        it 'converts rows to columns and vice versa' do
            expect(array.my_tranpose).to eq([
                [0,3,6],
                [1,4,7],
                [2,5,8]
            ])
        end
    end

    describe '#stock_picker' do
        let(:array) { [15.46, 21.12, 8.00, 8.23, 17.92, 16.48, 16.54, 17.00, 24.24, 10.17, 14.17] }
        let(:mixed_array) { array.reverse }

        it 'returns an array of two elements' do
            expect(array.stock_picker.length).to eq(2)
        end

        it 'returns the index representing the days of the stock prices' do
            expect(array.stock_picker[0].class).to eq(Integer)
        end

        it 'returns the index representing the days of the stock prices' do
            expect(array.stock_picker[1].class).to eq(Integer)        
        end

        it 'gives the days that would make the biggest profit' do
            expect(array.stock_picker).to eq([2,8])
        end

        it "doesn't take higher prices from previous days" do            
            expect(mixed_array.stock_picker).to eq([1, 2])
        end
    end
end

describe TowersOfHanoi do
    subject(:game) { TowersOfHanoi.new }

    describe '#initialize' do
        it 'has array @pieces' do
            expect(game.pieces.class).to eq(Array)
        end

        it 'contains a number representing each pieces in @pieces' do
            expect(game.pieces).to eq([3,2,1])
        end

        it 'initializes the game with a @towers array' do
            expect(game.towers.class).to eq(Array)
        end

        it 'places the pieces in the first tower, in descending order' do
            expect(game.towers).to eq([[3,2,1], [], []])
        end

    end

    describe '#move' do

        it 'takes in a starting tower and an ending tower as arguments' do
            expect { game.move(1, 2)}.not_to raise_error
        end

        it 'moves the top piece from one tower to the selected tower' do
            game.move(1,2)
            expect(game.towers).to eq([[3, 2], [1], []])
        end

    end

    describe '#valid_move?' do
        it 'takes in a starting tower and and ending tower as arguments' do 
            expect { game.valid_move?(1, 2) }.not_to raise_error
        end

        it 'does not allow moving from empty tower' do
            expect(game.valid_move?(3, 2)).to eq(false)
        end

        it 'always allows moving to an empty tower' do
            expect(game.valid_move?(1, 2)).to eq(true)
        end

        it 'does not allow moving onto a smaller disk' do
            game.move(1, 2)
            expect(game.valid_move?(1, 2)).to eq(false)
        end

        it 'allows all other moves' do
            game.move(1, 2)
            game.move(1, 3)
            expect(game.valid_move?(2, 3)).to eq(true)
        end
    end

    describe '#won?' do
        
        it 'is not won if any piece is not on tower 3' do
            game.move(1, 3)
            game.move(1, 2)
            game.move(3, 2)
            game.move(1, 3)
            game.move(2, 1)
            game.move(2, 3)
            expect(game.won?).to eq(false)
        end

        it 'is won when all pieces are on tower 3' do
            game.move(1, 3)
            game.move(1, 2)
            game.move(3, 2)
            game.move(1, 3)
            game.move(2, 1)
            game.move(2, 3)
            game.move(1, 3)
            expect(game.won?).to eq(true)
        end


    end
end