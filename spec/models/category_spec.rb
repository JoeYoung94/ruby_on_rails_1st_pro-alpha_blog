require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a valid factory" do
    category = FactoryGirl.build(:category)
    expect(category).to be_valid
  end
end
