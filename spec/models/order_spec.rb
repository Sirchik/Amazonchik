require 'rails_helper'
require 'aasm/rspec'

RSpec.describe Order, type: :model do

  required_fields = %w(total_price state)
  other_fields = %w(completed_date billing_address shipping_address)

  include_examples 'test fields', required_fields, other_fields

  it 'by default an order should have "in progress" state' do
    @order =  described_class.new
    expect(@order.state).to eq('in_progress')
  end
  it { should belong_to(:user)}
  it { should belong_to(:credit_card)}
  it { should have_many(:order_items)}
  # it { should belong_to(:billing_address)}
  # it { should belong_to(:shipping_address)}
  context '#add_item' do #'an order should be able to add a book to the order'
    before do
      @order = create(:order, state: 'in_progress')
      @category =  create(:category)
      @book =  create(:book, category: @category)
      @order_item = create(:order_item, order: @order, book: @book)
      @book_new = create(:book, category: @category)
    end
    it 'add book to new order' do
      @order = create(:order, state: 'in_progress', user: @user, credit_card: @credit_card)
      expect { @order.add_item(@book) }.to change{ @order.order_items.count }.by(1)
    end
    it 'add new book to existing order' do
      expect { @order.add_item(@book_new) }.to change{ @order.order_items.count }.by(1)
    end
    it 'add existing book to existing order' do
      expect { @order.add_item(@book) }.not_to change{ @order.order_items.count }
    end
    it 'expect can_modify?' do
      expect(@order).to receive(:can_modify?)
      @order.send(:add_item, @book)
    end
    it 'cannot add book to completed order' do
      @order = create(:order, state: 'delivered', user: @user, credit_card: @credit_card)
      @order.completed_date = DateTime.now
      expect { @order.add_item(@book_new) }.not_to change{ @order.order_items.count }
    end
    it 'raise wrong parametr error' do
      expect { @order.add_item }.to raise_error ArgumentError
    end
    it 'expect calculate_total' do
      expect(@order).to receive(:calculate_total)
      @order.add_item(@book)
    end
    it 'expect calculate_total with new book' do
      expect(@order).to receive(:calculate_total)
      @order.add_item(@book_new)
    end
  end
  # context '#cancel!' do
  #   before do
  #     @order = create(:order, state: 'in_progress')
  #     @order.cancel!
  #   end
  #   it 'has status canceled' do
  #     expect(@order.state).eql? :canceled
  #   end
  #   it 'has completed_date' do
  #     expect(@order.completed_date).to_not be_nil
  #   end
  #   it 'can not be modified' do
  #     expect(@order).not_to be_can_modify
  #   end
  #   it 'expect can_modify?' do
  #     expect(@order).to receive(:can_modify?)
  #     @order.send(:cancel!)
  #   end
  # end

  context '#can_modify?' do
    it 'cant modify canceled' do
      @order = create(:order, state: :canceled)
      expect(@order).not_to be_can_modify
    end
    it 'cant modify delivered' do
      @order = create(:order, state: :delivered)
      expect(@order).not_to be_can_modify
    end
    it 'can modify in_progress' do
      @order = create(:order, state: :in_progress)
      expect(@order).to be_can_modify
    end
    # it 'cant modify if completed_date present' do
    #   @order = create(:order, completed_date: Time.now)
    #   expect(@order).not_to be_can_modify
    # end
    # described_class.aasm.states.map(&:name).each { |state|
    #   it { 
    #     @order = create(:order, state: state)
    #     expect(@order).to be_can_modify
    #   } unless state == 'canceled' || state == 'delivered'
    # }
  end

  # context '.next_state!' do
  #   Order::STATUSES.each_with_index { |item, index|
  #     it { 
  #       @order = create(:order, state: item)
  #       @order.next_state!
  #       expect(@order.state).to eql(Order::STATUSES[index + 1])
  #     } unless index == 0 || item == Order::STATUSES.last
  #   }
  #   it 'canceled not changed' do
  #     @order = create(:order, state: Order::STATUSES.first)
  #     @order.next_state!
  #     expect(@order.state).to eql(Order::STATUSES.first)
  #   end
  #   it 'delivered not changed' do
  #     @order = create(:order, state: Order::STATUSES.last)
  #     @order.next_state!
  #     expect(@order.state).to eql(Order::STATUSES.last)
  #   end
  #   it 'changed completed_date' do
  #     @order = create(:order, state: Order::STATUSES[-2])
  #     expect { @order.next_state! }.to change{ @order.completed_date }
  #   end
  #   it 'expect can_modify?' do
  #     @order = Order.new
  #     expect(@order).to receive(:can_modify?)
  #     @order.send(:next_state!)
  #   end
  # end
  
  context '#calculate_total' do
    before do
      @order = create(:order, state: 'in_progress')
      @category =  create(:category)
      @book =  create(:book, category: @category)
      @order_item = create(:order_item, order: @order, book: @book, price: @book.price)
    end
    # it 'total price change' do
    #   expect { @order.calculate_total }.to change{ @order.total_price }
    # end
    it 'total price = order_item.price * quantity' do
      @order.calculate_total
      expect(@order.total_price).to eql(@order_item.price * @order_item.quantity)
    end
  end
  context 'empty test' do
    before do
      @order = create(:order, state: 'in_progress')
    end
    it 'empty if no order items' do
      expect(@order).to be_empty
    end
    it 'not empty if order items present' do
      @category =  create(:category)
      @book =  create(:book, category: @category)
      @order_item = create(:order_item, order: @order, book: @book, price: @book.price)
      expect(@order).not_to be_empty
    end
    it 'clears when empty! called' do
      @category =  create(:category)
      @book =  create(:book, category: @category)
      @order_items = create_list(:order_item, 3, order: @order, book: @book, price: @book.price)
      @order.empty!
      expect(@order).to be_empty
    end
  end
  
  it {should respond_to(:total_price)} # 'an order should be able to return a total price of the order'
  
  context 'aasm tests' do
    before do
      @order = described_class.new
    end
    it 'event process' do 
      expect(@order).to transition_from(:in_progress).to(:in_queue).on_event(:process)
    end
    it 'event deliver' do 
      expect(@order).to transition_from(:in_queue).to(:in_delivery).on_event(:deliver)
    end
    it 'event done' do 
      expect(@order).to transition_from(:in_delivery).to(:delivered).on_event(:done)
    end
    it 'event cancel' do
      [:in_progress, :in_queue, :in_delivery].each do |state|
        expect(@order).to transition_from(state).to(:canceled).on_event(:cancel)
      end
    end
    xit 'expect receive record_date' do
      expect(@order).to receive(:record_date)
      @order.cancel!
    end
  end
  
  it '#state_enum' do
    @order = described_class.new
    described_class.aasm.states.map(&:name).each do |state|
      expect(@order.state_enum).to eql(@order.aasm.states(:permitted => true).map(&:name))
    end
  end

  it '#record_date' do
    @order = described_class.new
    expect { @order.record_date }.to change{ @order.record_date }
  end

  it '#total_price_with_shipping' do
    order = create(:order, total_price: Faker::Number.decimal(2))
    shipping = create(:shipping)
    order_shipping = create(:order_shipping, order: order, shipping: shipping, price: shipping.price)
    totalprice = order.total_price_with_shipping
    expect(totalprice).to eql(order.total_price + order_shipping.price)
  end
  
  xcontext '#set_shipping' do
    
  end
  
  it '#to_s' do
    @order = create(:order)
    expect(@order.to_s).to eql("##{@order.id}")
  end

end
