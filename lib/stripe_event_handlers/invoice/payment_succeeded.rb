module StripeEventHandlers
  module Invoice
    class PaymentSucceeded < InvoiceHandler
      # TODO: check subscription metadata
      def run
        return unless eligible?

        ApplicationRecord.transaction do
          subscription.next_charge_at = Time.at(invoice.date) + Subscription::TIME_BETWEEN_VISITS
          subscription.next_visit_at = subscription.next_charge_at -
            Subscription::WINDOW_BETWEEN_VISIT_AND_PAYMENT
          subscription.mark_as_active
          subscription.save!

          visit.pay_with_stripe_invoice(invoice.id)
          visit.copy_previous_prescription unless visit.has_prescription?
          visit.save!
        end

        UserMailer.send_email(user: subscription.customer, template: :invoice_payment_succeeded)
      end
    end
  end
end

