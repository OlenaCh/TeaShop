require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validate a new address' do
    it "should have valid factory" do
      expect(FactoryGirl.build(:address)).to be_valid
    end

    it "triggers downcase_city on save" do
      address = FactoryGirl.create(:address)
      expect(address).to receive(:downcase_city)
      expect(address[:city]).to match(/[^A-Z]/)
      address.save
    end

    it "triggers downcase_address on save" do
      address = FactoryGirl.create(:address)
      expect(address).to receive(:downcase_address)
      expect(address[:address]).to match(/[^A-Z]/)
      address.save
    end

    it "should require a zip code" do
      expect(FactoryGirl.build(:address, :zip_code => "")).to be_invalid
    end

    it "should require a zip code no shorter than 4 symbols" do
      expect(FactoryGirl.build(:address, :zip_code => "a" * 3)).to be_invalid
    end

    it "should require a zip code no longer than 11 symbols" do
      expect(FactoryGirl.build(:address, :zip_code => "a" * 12)).to be_invalid
    end

    it "should require a city" do
      expect(FactoryGirl.build(:address, :city => "")).to be_invalid
    end

    it "should require a city no longer than 20 symbols" do
      expect(FactoryGirl.build(:address, :city => "a" * 21)).to be_invalid
    end

    it "should require a city with a certain format" do
      expect(FactoryGirl.build(:address, :city => "Lvi@v")).to be_invalid
      expect(FactoryGirl.build(:address, :city => "#####")).to be_invalid
      expect(FactoryGirl.build(:address, :city => "Lviv")).to be_valid
    end

    it "should require an address" do
      expect(FactoryGirl.build(:address, :address => "")).to be_invalid
    end

    it "should require an address no longer than 40 symbols" do
      expect(FactoryGirl.build(:address, :address => "a" * 41)).to be_invalid
    end
  end
end