class TwilioController < ApplicationController
  REQUIRED_PHOTO_COUNT = 3

  ##
  # Process incoming Twilio webhook requests.
  #
  # This action is the endpoint to which Twilio sends all incoming requests, i.e. texts and calls
  # to our Twilio number. Each environment (development, staging, and production) has its own
  # Twilio number, and our Twilio account is configured to send webhook requests to the proper URL.
  #
  # For development, use ngrok and update the webhook URL for the development phone number in the
  # Twilio console.
  def webhook
    @photo_count = params["NumMedia"].to_i
    @customer = Customer.find_by(phone: PhonyRails.normalize_number(params["From"]))

    if @customer && @photo_count.positive?
      # Send the Customer an acknowledgement text message.
      @customer.send_text_message(
        photo_acknowledgement_message(@photo_count, @photo_count + @customer.photos.count),
      )

      # Fetch and add the photos from the message.
      create_customer_photos_from_twilio_params(@customer, params)
    end

    render json: {status: "OK"}
  end

  ##
  # Parse the Twilio request parameters, retrieve the photos, and add them to the Customer.
  private def create_customer_photos_from_twilio_params(customer, params)
    (0...params["NumMedia"].to_i).each do |media_number|
      customer.photos.create!(
        image: URI.parse(URI.encode(params["MediaUrl#{media_number}"])),
      )

      customer.subscription.require_new_treatment_plan

      track("Added a photo", {source: "twilio"}, customer)
    end
  end

  ##
  # Given a number of photos, produce an acknowledgement message.
  private def photo_acknowledgement_message(new_photo_count, total_photo_count)
    if total_photo_count < REQUIRED_PHOTO_COUNT
      additional_message = " Please upload #{REQUIRED_PHOTO_COUNT - total_photo_count} more " \
        "photo#{REQUIRED_PHOTO_COUNT - total_photo_count == 1 ? '' : 's'} to complete your profile."
    else
      additional_message = ""
    end

    "We've received your #{new_photo_count} photo#{new_photo_count == 1 ? '' : 's'} and are " \
      "processing #{new_photo_count == 1 ? 'it' : 'them'}. " \
      "#{new_photo_count == 1 ? 'It' : 'they'} should appear in your profile in a few seconds!" +
      additional_message
  end
end
