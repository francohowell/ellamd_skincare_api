module TransactionScripts
  module Visit
    class CreateUpcoming
      attr_reader :subscription, :visit

      def initialize(subscription:)
        @subscription = subscription
        @visit = ::Visit.new
      end

      def run
        subscription.next_visit_at = nil

        if ::Subscription::Blocker.new(subscription).exists?
          subscription.needs_profile_update = true
          subscription.pause if subscription.active?
        end

        visit.customer = subscription.customer
        visit.payment_status = :unpaid

        successfully_saved = nil
        ApplicationRecord.transaction do
          successfully_saved = subscription.save && visit.save
          raise ActiveRecord::Rollback unless successfully_saved
        end

        if successfully_saved
          send_subscription_renewal_email
        else
          message = "Upcoming visit creation has failed. " \
                    "Subscription ##{subscription&.id} errors: " \
                    "#{subscription.errors.full_messages.join(', ')}. " \
                    "Visit errors: #{visit.errors.full_messages.join(', ')}"
          Raven.capture_message(message)
        end

        successfully_saved
      end

      private def send_subscription_renewal_email
        template = if subscription.active?
                     :recurring_visit_created
                   else
                      :recurring_visit_created_and_blocked
                   end

        UserMailer.send_email(template: template, user: subscription.customer)
      end
    end
  end
end
