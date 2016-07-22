require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validate a new user' do
    it "should have valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "should require a username" do
      expect(FactoryGirl.build(:user, :name => "")).to be_invalid
    end

    it "should require a username no longer than 50 symbols" do
      expect(FactoryGirl.build(:user, :name => "a" * 51)).to be_invalid
    end

    it "should require a zip code" do
      expect(FactoryGirl.build(:user, :zip_code => "")).to be_invalid
    end

    it "should require a zip code no longer than 10 symbols" do
      expect(FactoryGirl.build(:user, :zip_code => "a" * 11)).to be_invalid
    end

    it "should require a city" do
      expect(FactoryGirl.build(:user, :city => "")).to be_invalid
    end

    it "should require a city no longer than 20 symbols" do
      expect(FactoryGirl.build(:user, :city => "a" * 21)).to be_invalid
    end

    it "should require a city with a certain format" do
      expect(FactoryGirl.build(:user, :city => "Lvi7v")).to be_invalid
      expect(FactoryGirl.build(:user, :city => "#####")).to be_invalid
      expect(FactoryGirl.build(:user, :city => "Lviv")).to be_valid
    end

    it "should require an address" do
      expect(FactoryGirl.build(:user, :address => "")).to be_invalid
    end

    it "should require an address no longer than 50 symbols" do
      expect(FactoryGirl.build(:user, :address => "a" * 51)).to be_invalid
    end

    it "should require an email no longer than 100 symbols" do
      expect(FactoryGirl.build(:user, :email => "a" * 101)).to be_invalid
    end

    it "should require an email with a certain format" do
      expect(FactoryGirl.build(:user, :email => "olena.ukr.net")).to be_invalid
      expect(FactoryGirl.build(:user, :email => "o7ena@ukr")).to be_invalid
      expect(FactoryGirl.build(:user, :email => "o7ena@.ukr")).to be_invalid
    end
  end
end
