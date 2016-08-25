require 'rails_helper'

RSpec.describe OrdersProduct, type: :model do
  describe 'validate a new order' do
  	it "has valid factory" do
      expect(FactoryGirl.build(:orders_product)).to be_valid
    end

    it "requires shipment" do
      expect(FactoryGirl.build(:orders_product, :amount => "")).to be_invalid
    end

    it "requires shipment to be numeric" do
      expect(FactoryGirl.build(:orders_product, :amount => 'a')).to be_invalid
    end

    it "requires shipment to be more or equal zero" do
      expect(FactoryGirl.build(:orders_product, :amount => 2)).to be_valid
      expect(FactoryGirl.build(:orders_product, :amount => -1)).to be_invalid
    end
  end
end