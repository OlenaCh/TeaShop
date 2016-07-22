require 'spec_helper'

describe SessionsHelper do
  let! (:user) {
    user = FactoryGirl.create :user
  }

  describe "#login" do
    it "creates a session for a new user" do
      helper.log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  # describe "#current_user" do
  #   it "returns the user corresponding to the remember token cookie" do
  #     @current_user = user
  #     expect(helper.current_user?(user)).to be_truthy
  #   end
  # end

  describe "#current_user?" do
    it "returns true if the user is current user" do
      @current_user = user
      expect(helper.current_user?(user)).to be_truthy
    end
  end

  describe "#current_user?" do
    it "returns false if the user is not current user" do
      @current_user = nil
      expect(helper.current_user?(user)).to be_falsey
    end
  end

  describe "#logged_in?" do
    it "returns true if the user is logged in" do
      @current_user = user
      expect(helper.logged_in?).to be_truthy
    end
  end

  describe "#logged_in?" do
    it "returns false if the user is not logged in" do
      @current_user = nil
      expect(helper.logged_in?).to be_falsey
    end
  end
end
