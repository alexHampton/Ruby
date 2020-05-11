require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:dessert) { Dessert.new("cake", 2, chef) }
  let(:chef) { double("chef", :name => "chef andrews", :titleize => 'Chef Andrews the Great') }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(2)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new('cake', 'five', 'Chef Andrews') }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient('flour')
      expect(dessert.ingredients).to include('flour')
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      # dessert.add_ingredient('flour')
      # dessert.add_ingredient('eggs')
      # dessert.add_ingredient('milk')

      # better solution
      ingredients = ['flour', 'eggs', 'milk']
      ingredients.each { |ingredient| dessert.add_ingredient(ingredient) }

      expect(dessert.ingredients).to eq(ingredients)
      
      dessert.mix! # until dessert.ingredients[0] != 'flour'
      expect(dessert.ingredients).to_not eq(ingredients)
      expect(dessert.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(1)
      expect(dessert.quantity).to eq(1)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(3) }.to raise_error('not enough left!')
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(dessert.serve).to include("Chef Andrews the Great")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake).with(dessert).and_return("The dessert has been baked by the chef.")
      expect(dessert.make_more).to eq("The dessert has been baked by the chef.")
    end
  end
end
