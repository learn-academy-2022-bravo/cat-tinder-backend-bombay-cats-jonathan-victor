require 'rails_helper'

RSpec.describe Cat, type: :model do
    it "should validate name" do
        cat = Cat.create age: 3, enjoys: 'Going to the ocean and scubadiving', image: 'http://catimage.com'
        expect(cat.errors[:name]).to_not be_empty
    end
    it "should validate age" do
        cat = Cat.create name: "Brock", enjoys: 'Going to the ocean and scubadiving', image: 'http://catimage.com'
        expect(cat.errors[:age]).to_not be_empty
    end
    it "should validate enjoys" do
        cat = Cat.create name: "Brock", age: 3, image: 'http://catimage.com'
        expect(cat.errors[:enjoys]).to_not be_empty
    end
    it "should validate image" do
        cat = Cat.create name: "Brock", age: 3, enjoys: 'Going to the ocean and scubadiving'
        expect(cat.errors[:image]).to_not be_empty
    end
    it "should validate length for enjoys" do
        cat = Cat.create name: "Brock", age: 3, enjoys: 'ocean', image: 'http://catimage.com'
        expect(cat.errors[:enjoys]).to_not be_empty
    end
end
