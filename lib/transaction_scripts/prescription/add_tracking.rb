# Add tracking information to the Prescription and send the Customer an email.
module TransactionScripts
  module Prescription
    class AddTracking
      # How long to wait after tracking has been submitted for a Prescription
      # to send the Customer a "delivered successfully" email.
      ARTIFICIAL_DELIVERED_EMAIL_DELAY = 3.days

      attr_reader :prescription, :tracking_number

      def initialize(prescription:, tracking_number:)
        @prescription = prescription
        @tracking_number = tracking_number
      end

      def run!
        run or raise("Prescription tracking number has not been added")
      end

      def run
        successfully_saved = prescription.update(tracking_number: tracking_number)
        process_prescription if successfully_saved

        successfully_saved
      end

      # We immediately send a "shipped" email, and queue up a "delivered" email
      #   to be delivered after an artificial delay. We should integrate with
      #   some shipment-tracking service to actually know when the package is
      #   delivered.
      private def process_prescription
        UserMailer.send_prescription_shipped_email(prescription)
        UserMailer.delay(run_at: ARTIFICIAL_DELIVERED_EMAIL_DELAY.from_now)
                  .send_prescription_delivered_email(prescription)
      end
    end
  end
end
