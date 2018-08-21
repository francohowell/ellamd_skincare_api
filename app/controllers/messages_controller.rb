class MessagesController < ApplicationController
  def index
    authorize! :read, Message

    render json: current_identity.user.messages.all
  end

  def create
    authorize! :create, Message

    customer = current_identity.user
    physician = customer.physician

    message = Message.new(customer: customer,
                          physician: physician,
                          content: params[:message],
                          from_customer: true)

    if message.save
      render json: message
    else
      render json: {error: "The message could not be created"}
    end
  end
end
