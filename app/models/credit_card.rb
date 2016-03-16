class CreditCard < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :number, presence: true
  validates :cvv, presence: true
  validates :exp_month, presence: true
  validates :exp_year, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  def default!
    current_default_credit_cards = user.credit_cards.where(default: ActiveRecord::Type::Boolean.new.type_cast_from_user(true))
    current_default_credit_cards.each do |card|
      addr.default = ActiveRecord::Type::Boolean.new.type_cast_from_user(false)
      addr.save
    end
    self.default = ActiveRecord::Type::Boolean.new.type_cast_from_user(true)
    self.save
  end

  def is_card_valid?
    # number.gsub(/\s+/, "").size == 16 & cvv.gsub(/\s+/, "").size == 3 to set in validators
     exp_year > Date.today.year or ( exp_year == Date.today.year & exp_month >= Date.today.month )
    
  end

  def to_s
    "%s %s%s %s (%02d/%02d)" % [number[1..4], number[5..6], "** ****", number[-4..-1], exp_month, exp_year]
  end
end
