# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  status                         :integer          default("inexistent"), not null
#  customer_id                    :integer          not null
#  stripe_subscription_id         :string
#  next_visit_at                  :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  stripe_customer_id             :string
#  initial_treatment_plan_is_free :boolean          default(FALSE), not null
#  stripe_coupon_id               :string
#  needs_treatment_plan           :boolean          default(TRUE), not null
#  has_payment_source             :boolean          default(FALSE), not null
#  next_charge_at                 :datetime
#  needs_profile_update           :boolean          default(FALSE), not null
#

require "rails_helper"

describe Subscription do
  let(:hannibal_lecter) { physicians(:hannibal_lecter) }
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  describe "#stripe_customer" do
    it "retrieves existing customer when :stripe_customer_id is present" do
      VCR.use_cassette "Subscription#stripe_customer existing" do
        ben_raspail_stripe_customer = ben_raspail_subscription.stripe_customer
        expect(ben_raspail_stripe_customer.email).to eq("ellamdcustomer+1@gmail.com")
      end
    end

    it "creates new stripe customer when :stripe_customer_id is blank and updates self" do
      new_customer     = FactoryBot.create(:customer, physician: hannibal_lecter)
      new_subscription = new_customer.subscription
      new_identity     = FactoryBot.create(
        :identity,
        email: "ellamdcustomer+new@gmail.com",
        user: new_customer
      )

      VCR.use_cassette "Subscription#stripe_customer new" do
        new_stripe_customer = new_subscription.stripe_customer
        new_subscription.reload

        expect(new_stripe_customer.email).to eq("ellamdcustomer+new@gmail.com")
        expect(new_subscription.stripe_customer_id).to be_present
      end
    end
  end
end
