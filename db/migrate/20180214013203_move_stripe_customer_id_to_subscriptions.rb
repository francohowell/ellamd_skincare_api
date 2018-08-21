class MoveStripeCustomerIdToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :stripe_customer_id, :string

    Customer.find_each do |customer|
      subscription = customer.build_subscription
      subscription.stripe_customer_id = customer.stripe_customer_id
      subscription.save!
    end

    remove_column :customers, :stripe_customer_id
  end
end
