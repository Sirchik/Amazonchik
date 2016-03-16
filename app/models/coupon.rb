class Coupon < ActiveRecord::Base


  def self.get_coupon_by_code(coupon_code)
    res = {}
    if coupon_code == '~=EMPTY=~'
      res[:status] = :cleared
    elsif coupon_new = Coupon.find_by_code(coupon_code)
      start_date = coupon_new.start_date
      end_date = coupon_new.end_date
      if start_date < DateTime.now && end_date > DateTime.now
        res[:coupon] = coupon_new
        res[:status] = :ok
      else
        res[:status] = :expired
      end
    else
      res[:status] = :not_found
    end
    res
  end

end
