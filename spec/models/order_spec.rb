require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validate a new order' do
    it "has valid factory" do
      expect(FactoryGirl.build(:order)).to be_valid
    end

    it "requires shipment" do
      expect(FactoryGirl.build(:order, :shipment => "")).to be_invalid
    end

    it "requires shipment to be numeric" do
      expect(FactoryGirl.build(:order, :shipment => 'a')).to be_invalid
    end

    it "requires shipment to be more or equal zero" do
      expect(FactoryGirl.build(:order, :shipment => 2)).to be_valid
      expect(FactoryGirl.build(:order, :shipment => -1)).to be_invalid
    end

    it "requires subtotal" do
      expect(FactoryGirl.build(:order, :subtotal => "")).to be_invalid
    end

    it "requires shipment to be numeric" do
      expect(FactoryGirl.build(:order, :subtotal => 'a')).to be_invalid
    end

    it "requires shipment to be more or equal zero" do
      expect(FactoryGirl.build(:order, :subtotal => 2)).to be_valid
      expect(FactoryGirl.build(:order, :subtotal => -1)).to be_invalid
    end

    it "requires shipment" do
      expect(FactoryGirl.build(:order, :grand_total => "")).to be_invalid
    end

    it "requires shipment to be numeric" do
      expect(FactoryGirl.build(:order, :grand_total => 'a')).to be_invalid
    end

    it "requires shipment to be more or equal zero" do
      expect(FactoryGirl.build(:order, :grand_total => 2)).to be_valid
      expect(FactoryGirl.build(:order, :grand_total => -1)).to be_invalid
    end
  end
end