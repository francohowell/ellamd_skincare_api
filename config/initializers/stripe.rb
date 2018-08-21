require "stripe"

Stripe.api_key = Figaro.env.stripe_secret_key!
StripeEvent.signing_secret = Figaro.env.stripe_signing_secret!

StripeEvent.configure do |events|
  events.subscribe "invoice.payment_succeeded", StripeEventHandlers::Invoice::PaymentSucceeded
  events.subscribe "invoice.payment_failed",    StripeEventHandlers::Invoice::PaymentFailed
  events.subscribe "coupon.deleted",            StripeEventHandlers::Coupon::Deleted
end
