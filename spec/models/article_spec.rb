require 'rails_helper'

RSpec.describe Article, type: :model do
  it "has a valid factory" do
    article = FactoryGirl.build(:article)
    expect(article).to be_valid
  end
end

describe Article do
  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:description)}
end
