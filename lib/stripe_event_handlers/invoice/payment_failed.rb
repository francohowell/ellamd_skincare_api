module StripeEventHandlers
  module Invoice
    class PaymentFailed < InvoiceHandler
      # TODO: check subscription metadata
      def run
        return unless eligible?

        ApplicationRecord.transaction do
          visit.stripe_invoice_id = invoice.id
          visit.save!

          subscription.mark_as_unpaid
        end

        UserMailer.send_email(user: subscription.customer, template: :invoice_payment_failed)
      end
    end
  end
end
