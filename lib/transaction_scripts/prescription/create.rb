module TransactionScripts
  module Prescription
    class Create
      attr_reader :prescription, :params

      delegate :visit, to: :prescription

      def initialize(params:)
        @prescription = ::Prescription.new
        @params = params
      end

      def run!
        run or raise("Prescription has not been saved")
      end

      def run
        prescription.assign_attributes(params)

        is_saved = prescription.save
        process_prescription if is_saved
        is_saved
      end

      private def process_prescription
        send_prescription_ready_email
      end

      ##
      # Send the Customer an email about the Prescription.
      #
      # If the Customer has already paid the visit or if the visit is free, they'll get an email
      # saying the Prescription is going to be fulfilled. Otherwise, they get a reminder to pay.
      private def send_prescription_ready_email
        if visit.already_paid?
          UserMailer.send_prescription_ready_paid_email(prescription)
        else
          UserMailer.send_prescription_ready_unpaid_email(prescription)
        end
      end
    end
  end
end
