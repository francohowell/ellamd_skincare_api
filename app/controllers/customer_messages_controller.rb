class CustomerMessagesController < ApplicationController
  def index
    authorize! :read, Message

    messages = customer.messages.with_physician(current_identity.user.id)

    render json: messages.all
  end

  def create
    authorize! :create, Message

    message = Message.new(customer: customer,
                          physician: customer.physician,
                          content: message_params[:message],
                          from_customer: false)

    if message.save
      render json: message
    else
      render json: { error: "The message could not be created" }
    end
  end

  private def customer
    Customer.find(params[:customer_id])
  end

  private def message_params
    params.require(:customer_message).permit(:message)
  end
end
