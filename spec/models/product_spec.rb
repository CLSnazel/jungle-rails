require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name:"Accessories")
      @category.save!

      @name = "Earrings"
      @price = 5000
      @quantity = 100
    end
    before(:each) do
      @new_product = Product.new(name:"Earrings", price:5000, quantity:100, category:@category) 
    end 

    context 'All valid fields' do
      it 'should successfully add to db' do
        
        expect{@new_product.save}.to change{Product.count}.by(1)
      end
    end

    context 'Missing fields' do
      # validates :name, presence: true
      it 'should fail without a name' do
        @new_product.name = nil
        expect(@new_product).to_not be_valid
        expect(@new_product.errors.full_messages).to eq ["Name can't be blank"]
      end
      
      # validates :price, presence: true
      it 'should fail without a price' do
        @new_product.price_cents = nil
        expect(@new_product).to_not be_valid
        expect(@new_product.errors.full_messages).to include "Price can't be blank"
      end

      # validates :quantity, presence: true
      it 'should fail without a quantity' do
        @new_product.quantity = nil
        expect(@new_product).to_not be_valid
        expect(@new_product.errors.full_messages).to include "Quantity can't be blank"
      end

      # validates :category, presence: true
      it 'should fail without a category' do
        @new_product.category_id = nil
        expect(@new_product).to_not be_valid
        expect(@new_product.errors.full_messages).to include "Category can't be blank"
      end
    end



  end
end
