require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validate a new user' do
    it "should have valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "triggers downcase_city on save" do
      user = FactoryGirl.create(:user)
      expect(user).to receive(:downcase_city)
      expect(user[:city]).to match(/[^A-Z]/)
      user.save
    end

    it "triggers downcase_address on save" do
      user = FactoryGirl.create(:user)
      expect(user).to receive(:downcase_address)
      expect(user[:address]).to match(/[^A-Z]/)
      user.save
    end

    it "should require a username" do
      expect(FactoryGirl.build(:user, :name => "")).to be_invalid
    end

    it "should require a username no longer than 40 symbols" do
      expect(FactoryGirl.build(:user, :name => "a" * 41)).to be_invalid
    end

    it "should require a zip code" do
      expect(FactoryGirl.build(:user, :zip_code => "")).to be_invalid
    end

    it "should require a zip code no shorter than 4 symbols" do
      expect(FactoryGirl.build(:user, :zip_code => "a" * 3)).to be_invalid
    end

    it "should require a zip code no longer than 11 symbols" do
      expect(FactoryGirl.build(:user, :zip_code => "a" * 12)).to be_invalid
    end

    it "should require a city" do
      expect(FactoryGirl.build(:user, :city => "")).to be_invalid
    end

    it "should require a city no longer than 20 symbols" do
      expect(FactoryGirl.build(:user, :city => "a" * 21)).to be_invalid
    end

    it "should require a city with a certain format" do
      expect(FactoryGirl.build(:user, :city => "Lvi@v")).to be_invalid
      expect(FactoryGirl.build(:user, :city => "#####")).to be_invalid
      expect(FactoryGirl.build(:user, :city => "Lviv")).to be_valid
    end

    it "should require an address" do
      expect(FactoryGirl.build(:user, :address => "")).to be_invalid
    end

    it "should require an address no longer than 40 symbols" do
      expect(FactoryGirl.build(:user, :address => "a" * 41)).to be_invalid
    end

    # it "should downcast address before saving in db" do
    #   expect(FactoryGirl.build(:user, :address => "a" * 41)).to be_invalid
    # end
  end
end