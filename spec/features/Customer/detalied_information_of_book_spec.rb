require 'rails_helper'
require 'features/features_spec_helper'

feature 'User can view detailed information about a book on a book page' do

  scenario "description" do
    @books =  create_list(:book, 10,  category: nil)
    @books.each do |book|
      visit book_path(book)
      expect(page).to have_content(book.description)
    end
  end

end