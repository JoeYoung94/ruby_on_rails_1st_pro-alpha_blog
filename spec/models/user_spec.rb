require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  context "invlid user models" do
    it "invalid username" do
      user = FactoryGirl.build(:user)
      user.username = '1'
      expect(user).not_to be_valid
    end

    it "invalid email" do
      user = FactoryGirl.build(:user)
      user.email = "useremail@"
      expect(user).not_to be_valid
    end
  end
end
