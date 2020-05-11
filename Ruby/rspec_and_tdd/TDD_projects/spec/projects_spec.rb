require 'rspec'
require 'projects.rb'

describe Array do
    subject(:array) { Array.new }

    describe '#my_uniq' do
        let(:array) { [1,2,3,2,4,5,5] }

        it 'should take in an Array and return a new array' do
            expect(array.my_uniq.class).to be(Array)
        end

        it 'should contain every unique item of the original array' do
            expect(array.my_uniq).to include(1, 2, 3, 4, 5)
        end

        it 'should have only one of each unique item' do 
            expect(array.my_uniq).to eq([1,2,3,4,5])
        end

    end

    describe '#two_sum' do
        context 'with no matching pairs whose sum equals 0' do
            let(:array) { [-2, 0, 1, 3] }

            it 'should return an empty array' do 
                expect(array.two_sum).to eq([])
            end
        end

        context 'with matching pairs whose sum equals 0' do
            let(:array) { [-2, -1, 0, 1, 2] }

            it 'should return a 2-dimensional array' do
                expect(array.two_sum.length).to eq(2)
                expect(array.two_sum.flatten.length).to eq(4)
            end

            it 'should return matching indexes' do
                expect(array.two_sum).to eq([ [0, 4], [1, 3] ])
            end

            it 'should be sorted smaller index to bigger index' do
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

        it 'should return an array' do
            expect(array.my_tranpose.class).to eq(Array)
        end

        it 'should have the same length as the original array' do
            expect(array.my_tranpose.length).to eq(3)
        end

        it 'should convert rows to columns and vice versa' do
            expect(array.my_tranpose).to eq([
                [0,3,6],
                [1,4,7],
                [2,5,8]
            ])
        end
    end

    describe '#stock_picker' do
    let(:array) { [15.46, 21.12, 8.00, 8.23, 17.92, 16.48, 16.54, 17.00, 24.24, 10.17, 14.17] }

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

        
            

    end
end