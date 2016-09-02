require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validate a new product' do
    it "has valid factory" do
      expect(FactoryGirl.build(:product)).to be_valid
    end

    it "requires a title" do
      expect(FactoryGirl.build(:product, :title => "")).to be_invalid
    end

    it "requires a title no shorter than 2 symbols" do
      expect(FactoryGirl.build(:product, :title => "a" * 1)).to be_invalid
    end

    it "requires a title no longer than 60 symbols" do
      expect(FactoryGirl.build(:product, :title => "a" * 61)).to be_invalid
    end

    it "validates uniqueness of title" do
      Product.create!(:title => "Tea", :short_description => "Black tea",
                      :long_description => "Very tasty tea", :price => "20.0")
      product = Product.new(:title => 'Tea', :short_description => "Green tea",
                         :long_description => "Indian tea", :price => "30.0")
      expect(product).to be_invalid
    end

    it "requires a short description" do
      expect(FactoryGirl.build(:product, :short_description => "")).to be_invalid
    end

    it "requires a short description no shorter than 2 symbols" do
      expect(FactoryGirl.build(:product, :short_description => "a" * 1)).to be_invalid
    end

    it "requires a short description no longer than 100 symbols" do
      expect(FactoryGirl.build(:product, :short_description => "a" * 101)).to be_invalid
    end

    it "requires a long description" do
      expect(FactoryGirl.build(:product, :long_description => "")).to be_invalid
    end

    it "requires a long description no shorter than 2 symbols" do
      expect(FactoryGirl.build(:product, :long_description => "a" * 1)).to be_invalid
    end

    it "requires a long description no longer than 500 symbols" do
      expect(FactoryGirl.build(:product, :long_description => "a" * 501)).to be_invalid
    end

    it "requires a price" do
      expect(FactoryGirl.build(:product, :price => "")).to be_invalid
    end

    it "requires a numeric price" do
      expect(FactoryGirl.build(:product, :price => "twenty")).to be_invalid
      expect(FactoryGirl.build(:product, :price => "20.0")).to be_valid
    end

    context 'has_many associations' do
      let!(:address) {
        address = FactoryGirl.create(:address)
      }

      let!(:shipment) {
        shipment = FactoryGirl.create(:shipment)
      }

      it "can have one and more orders" do
        product = FactoryGirl.create(:product)
        order1 = product.orders.create!(shipment_id: shipment.id, address_id: address.id, subtotal: 7.0, grand_total: 10.0)
        order2 = product.orders.create!(shipment_id: shipment.id, address_id: address.id, subtotal: 7.0, grand_total: 15.0)
        expect(product.orders).to eq([order1, order2])
      end

      it "can have one and more orders_product" do
        product = FactoryGirl.create(:product)
        order = FactoryGirl.create(:order)
        orders_product1 = product.orders_products.create!(product_id: product.id, order_id: order.id, amount: 2)
        orders_product2 = product.orders_products.create!(product_id: product.id, order_id: order.id, amount: 5)
        expect(product.orders_products).to eq([orders_product1, orders_product2])
      end
    end
  end
end