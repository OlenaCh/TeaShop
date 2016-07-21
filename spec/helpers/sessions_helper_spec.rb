require 'spec_helper'

describe SessionsHelper do
  let! (:user) { user = FactoryGirl.create :user }

  describe "#login" do
    it "creates a session for a new user" do
      helper.log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe "#current_user" do
    it "assigns a current user" do
      #
    end
  end
end