require 'rails_helper'
require 'features/features_spec_helper'

feature 'User can navigate the site by categories' do
  background do
    @categories = create_list(:category, 3)
    @categories.each do |category|
      create_list(:book, rand(5) + 1,  category: category)
    end
    visit books_path
    @shop = page.find('div.col-xs-10')
  end

  scenario 'see all books' do
    expect(@shop.find_all('div.col-xs-4').count).to eql(Book.count)
  end

  scenario "see books by category" do
    Category.all.each do |category|
      click_link category.title
      expect(page.find('div.col-xs-10').find_all('div.col-xs-4').count).to eql(Book.where(category: category).count)
    end
  end

end