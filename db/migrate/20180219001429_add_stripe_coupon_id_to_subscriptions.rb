class AddStripeCouponIdToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :stripe_coupon_id, :string
  end
end
