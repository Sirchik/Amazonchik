class AddDefaultToCreditCard < ActiveRecord::Migration
  def change
    add_column :credit_cards, :default, :boolean, default: false, null: false
  end
end
