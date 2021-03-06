require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a valid factory" do
    category = FactoryGirl.build(:category)
    expect(category).to be_valid
  end

  context "invalid operations" do
    it "invalid category name" do
      category = FactoryGirl.build(:category)
      category.name = '1'
      expect(category).not_to be_valid
    end
  end
end
