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

describe SubscriptionSerializer do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  it "successfully renders Subscription as json" do
    result = serialize(ben_raspail_subscription)
    expect(result["id"]).to be_present
  end
end
