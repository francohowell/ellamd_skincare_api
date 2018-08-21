module Helpers
  module Stripe
    def stripe_event(event_fixture)
      plaintext = File.read("#{Rails.root}/spec/support/stripe_events/#{event_fixture}.json")
      json = JSON.parse(plaintext, symbolize_names: true)
      event = ::Stripe::Event.construct_from(json)

      OpenStruct.new(data: event)
    end
  end
end
