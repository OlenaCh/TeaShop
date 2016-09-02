require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validate a new order' do
    it "has valid factory" do
      expect(FactoryGirl.build(:order)).to be_valid
    end

    it "requires subtotal" do
      expect(FactoryGirl.build(:order, :subtotal => "")).to be_invalid
    end

    it "requires subtotal to be numeric" do
      expect(FactoryGirl.build(:order, :subtotal => 'a')).to be_invalid
    end

    it "requires subtotal to be more or equal zero" do
      expect(FactoryGirl.build(:order, :subtotal => 2)).to be_valid
      expect(FactoryGirl.build(:order, :subtotal => -1)).to be_invalid
    end

    it "requires grand total" do
      expect(FactoryGirl.build(:order, :grand_total => "")).to be_invalid
    end

    it "requires grand total to be numeric" do
      expect(FactoryGirl.build(:order, :grand_total => 'a')).to be_invalid
    end

    it "requires grand total to be more or equal zero" do
      expect(FactoryGirl.build(:order, :grand_total => 2)).to be_valid
      expect(FactoryGirl.build(:order, :grand_total => -1)).to be_invalid
    end

    it "can have one and more orders_product" do
      product = FactoryGirl.create(:product)
      order = FactoryGirl.create(:order)
      orders_product1 = order.orders_products.create!(product_id: product.id, order_id: order.id, amount: 2)
      orders_product2 = order.orders_products.create!(product_id: product.id, order_id: order.id, amount: 5)
      expect(order.orders_products).to eq([orders_product1, orders_product2])
    end
  end
end