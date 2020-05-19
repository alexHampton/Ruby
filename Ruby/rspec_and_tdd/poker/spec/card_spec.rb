# require 'rspec'
# require 'card.rb'

# describe Card do
#     subject(:card) { Card.new('KC') }

    
#     describe '#initialize' do

#         it 'takes in a string and sets the value' do
#             expect(card.value).to eq('KC')
#         end

#         it 'raises an error if value is not a string' do
#             expect {Card.new(1)}.to raise_error("Value must be a string")
#         end

#         it 'will only initialize if string is a length of 2' do
#             expect {Card.new('king of clubs') }.to raise_error("The value must have only two chars.")
#         end

#         context 'when the first char is not a card value' do
#             it 'will not initialize the card' do
#                 expect { Card.new('R8') }.to raise_error("The first char should be the card value (2-9, T, A, K, Q, J)")
#             end
#         end
#         context 'when the second char is not a face value' do
#             it 'will not initialize the card' do
#                 expect { Card.new('KJ') }.to raise_error("The second char should be the face value (H, D, C, or S)")
#             end
#         end
#     end

#     describe "::values" do
#         it 'returns an array of all possible card values' do
#             expect(Card.values).to eq(%w(A 2 3 4 5 6 7 8 9 T J Q K))
#         end
#     end

#     describe "::face_values" do
#         it 'returns an array of all possible face values' do
#             expect(Card.faces).to eq(%w(H D C S))
#         end
#     end

#     describe "#numerical_value" do
#         it 'returns a number representing the value of the card' do
#             expect(card.numerical_value).to eq(13)
#         end
#     end

#     describe "#face_value" do
#         it 'returns the letter depicting the face of the card' do
#             expect(card.face_value).to eq('C')
#         end
#     end
# end