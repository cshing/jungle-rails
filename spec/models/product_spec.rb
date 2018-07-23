require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validation' do
    it "is valid with all four valid attributes" do
      @category = Category.new(name: 'Fruit')
      @category.save!
      @product = @category.products.create(name: 'Apple', price: 100, quantity: 50, category: @category)
      @product.save

      expect(@product).to be_valid
      # expect(@product.valid?).to be true
    end

    it "is not valid without a name" do
      @category = Category.new(name: 'Fruit')
      @category.save!
      @product = @category.products.create(name: nil, price: 100, quantity: 50, category: @category)
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
  
    it "is not valid without a price" do
      @category = Category.new(name: 'Fruit')
      @category.save!
      @product = @category.products.create(name: 'Apple', price: nil, quantity: 50, category: @category)
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end

    it "is not valid without a quantity" do
      @category = Category.new(name: 'Fruit')
      @category.save!
      @product = @category.products.create(name: 'Apple', price: 100, quantity: nil, category: @category)
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "is not valid without a category" do
      @product = Product.new(name: 'Apple', price: 200, quantity: 50, category: nil)
      @product.save
      @product.errors.full_messages

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
