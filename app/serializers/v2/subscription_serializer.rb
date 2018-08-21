module V2
  class SubscriptionSerializer
    attr_reader :subscription, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(subscription, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @subscription = subscription
      @mode = mode
    end

    def as_json
      return nil if subscription.nil?

      {
        "id" => subscription.id,
        "status" => subscription.status,
        "stripe-customer-id" => subscription.stripe_customer_id,
        "stripe-subscription-id" => subscription.stripe_subscription_id,
        "stripe-coupon-id" => subscription.stripe_coupon_id,
        "next-visit-at" => subscription.next_visit_at,
        "next-charge-at" => subscription.next_charge_at,
        "initial-treatment-plan-is-free" => subscription.initial_treatment_plan_is_free,
        "has-payment-source" => subscription.has_payment_source,
        "needs-treatment-plan" => subscription.needs_treatment_plan,
        "needs-profile-update" => subscription.needs_profile_update,
      }
    end
  end
end












