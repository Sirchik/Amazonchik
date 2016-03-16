require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  required_fields = %w(number cvv exp_month exp_year firstname lastname)

  include_examples 'test fields', required_fields, []

  it {should belong_to(:user)}
  it {should have_many(:orders)}
  
  
  it '#to_s' do
    @credit_card = create(:credit_card)
    test_string = "%s %s%s %s (%02d/%02d)" % [@credit_card.number[1..4], @credit_card.number[5..6], "** ****", @credit_card.number[-4..-1], @credit_card.exp_month, @credit_card.exp_year]
    expect(@credit_card.to_s).to eql(test_string)
  end
  
  xit '#default!' do
    
  end
  
  xit '#is_card_valid?' do
    
  end

end
