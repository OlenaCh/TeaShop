require 'rails_helper'

RSpec.describe Shipment, type: :model do
  describe 'validate a new shipment' do
    it "has valid factory" do
      expect(FactoryGirl.build(:shipment)).to be_valid
    end

    it "should require a title" do
      expect(FactoryGirl.build(:shipment, :title => "")).to be_invalid
    end

    it "should require a title no longer than 40 symbols" do
      expect(FactoryGirl.build(:shipment, :title => "a" * 41)).to be_invalid
    end

    it "requires price to be numeric" do
      expect(FactoryGirl.build(:shipment, :price => 'a')).to be_invalid
    end

    it "requires price to be more or equal zero" do
      expect(FactoryGirl.build(:shipment, :price => 2)).to be_valid
      expect(FactoryGirl.build(:shipment, :price => -1)).to be_invalid
    end

    context 'has_many associations' do
      let!(:address) {
        address = FactoryGirl.create(:address)
      }

      it "can have one and more orders" do
        shipment = FactoryGirl.create(:shipment)
        order1 = shipment.orders.create!(shipment_id: shipment.id, address_id: address.id, subtotal: 7.0, grand_total: 10.0)
        order2 = shipment.orders.create!(shipment_id: shipment.id, address_id: address.id, subtotal: 7.0, grand_total: 15.0)
        expect(shipment.orders).to eq([order1, order2])
      end
    end
  end
end