require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    assign(:book, Book.new(
      :title => "MyString",
      :description => "MyString",
      :price => "9.99",
      :stock => 1,
      :author => nil,
      :category => nil
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input#book_title[name=?]", "book[title]"

      assert_select "input#book_description[name=?]", "book[description]"

      assert_select "input#book_price[name=?]", "book[price]"

      assert_select "input#book_stock[name=?]", "book[stock]"

      assert_select "input#book_author_id[name=?]", "book[author_id]"

      assert_select "input#book_category_id[name=?]", "book[category_id]"
    end
  end
end
