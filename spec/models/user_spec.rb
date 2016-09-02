require 'rails_helper'

RSpec.describe User, type: :model do 
  describe 'validate a new user' do
    it "should have valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "should require a username" do
      expect(FactoryGirl.build(:user, :name => "")).to be_invalid
    end

    it "should require a username no longer than 40 symbols" do
      expect(FactoryGirl.build(:user, :name => "a" * 41)).to be_invalid
    end

    context 'has_many associations' do
      let!(:address) {
      address = FactoryGirl.create(:address)
      }

      let!(:shipment) {
        shipment = FactoryGirl.create(:shipment)
      }

      it "can have one and more order" do
        user = FactoryGirl.create(:user)
        order1 = user.orders.create!(shipment_id: shipment.id, address_id: address.id, subtotal: 7.0, grand_total: 10.0)
        order2 = user.orders.create!(shipment_id: shipment.id, address_id: address.id, subtotal: 7.0, grand_total: 15.0)
        expect(user.orders).to eq([order1, order2])
      end

      it "can have one and more addresses" do
        user = FactoryGirl.create(:user)
        address1 = user.addresses.create!(city: 'Lviv', zip_code: '12345', address: 'Lviv')
        address2 = user.addresses.create!(city: 'New York', zip_code: '12345', address: 'New York')
        expect(user.addresses).to eq([address1, address2])
      end
    end
  end
end