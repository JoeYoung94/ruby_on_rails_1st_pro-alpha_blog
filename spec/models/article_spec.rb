require 'rails_helper'

RSpec.describe Article, type: :model do

  it "has a valid factory" do
    article = FactoryGirl.build(:article)
    expect(article).to be_valid
  end
  context 'articles invalid operations' do
    it "invalid title" do
      article = FactoryGirl.build(:article)
      article.title = '12'
      expect(article).not_to be_valid
    end

    it "invalid description" do
      article = FactoryGirl.build(:article)
      article.description = 'tooshort'
      expect(article).not_to be_valid
    end
  end
end
