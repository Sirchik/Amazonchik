require 'rails_helper'
require 'features/features_spec_helper'

feature 'User can put books into a "shopping cart" and buy them when I am done shopping' do
  background do
    @book = create(:book, category: nil)
    @other_book = create(:book, category: nil)
  end

  xscenario "add one book" do
    visit book_path(@book)
    click_button 'Add to cart'
    expect(page).to have_content(@book.to_s)
    expect(page.document.find_by_id("order_item_#{@book.id}").find('.book_quantity').text).to eq("1")
  end

  xscenario "add some books" do
    visit book_path(@book)
    books_count = rand(5) + 1
    fill_in 'book-quantity', with: books_count
    click_button 'Add to cart'
    expect(page).to have_content(@book.to_s)
    byebug
    expect(page.document.find_by_id("order_item_#{@book.id}").find('.book_quantity').text).to eq(books_count.to_s)
  end

  xscenario "add same book" do
    visit book_path(@book)
    click_button 'Add to cart'
    visit book_path(@book)
    click_button 'Add to cart'
    expect(page).to have_content(@book.to_s)
    expect(page.document.find_by_id("order_item_#{@book.id}").find('.book_quantity').text).to eq("2")
  end

end