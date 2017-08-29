require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) {  User.create!(username: "tk") }

  it {should validate_presence_of(:username) }
  it {should validate_uniqueness_of(:username)}

  describe "User::find_by_credentials" do

    it "finds a user by username" do
      user = User.create!(username: 'tk2')
      expect(User.find_by_credentials("tk2")).to eq(user)
    end
    it "returns nil if no user is found" do
      expect(User.find_by_credentials("nouserhasthisname")).to eq(nil)
    end
  end
end
