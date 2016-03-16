class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.decimal :discount, precision: 5, scale: 2, null: false
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end

    add_index :coupons, :code, unique: true
  end
end
