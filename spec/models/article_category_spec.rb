require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do
  it "has a valid factory" do
    article_category = FactoryGirl.build(:article_category)
    expect(article_category).to be_valid
  end
end
