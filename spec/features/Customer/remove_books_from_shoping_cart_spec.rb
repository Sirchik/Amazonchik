require 'rails_helper'
require 'features/features_spec_helper'

feature 'User can remove books from my cart before completing an order' do
  background do
    @order = create(:order)
    session[:order_id] = order.id
    create_list(:order_item, 5, order: order)
  end

  # scenario "add one book" do
  #   visit book_path(@book)
  #   click_button 'Add to cart'
  #   expect(page).to have_content(@book.to_s)
  #   # expect(page.find('input#book-quantity').value).to eq(1)
  # end

  # scenario "add some books" do
  #   visit book_path(@book)
  #   books_count = rand(5) + 1
  #   fill_in 'book-quantity', with: books_count
  #   click_button 'Add to cart'
  #   expect(page).to have_content(@book.to_s)
  #   # expect(page.find('input#book-quantity').value).to eq(books_count)
  # end

  # scenario "add same book" do
  #   visit book_path(@book)
  #   click_button 'Add to cart'
  #   visit book_path(@book)
  #   click_button 'Add to cart'
  #   expect(page).to have_content(@book.to_s)
  #   # expect(page.find('input#book-quantity').value).to eq(2)
  # end

end