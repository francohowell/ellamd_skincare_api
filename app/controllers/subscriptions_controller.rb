class SubscriptionsController < ApplicationController
  before_action :set_subscription

  def payment_details
    authorize! :read, @subscription

    details = Subscription::PaymentDetails.new(@subscription)
    render json: {"payment-details" => details.as_json}
  end

  def discount_details
    authorize! :read, @subscription

    details = Subscription::DiscountDetails.new(@subscription)
    render json: {"discount-details" => details.as_json}
  end

  def start
    authorize! :update, @subscription

    ts = TransactionScripts::Subscription::Start.new(
      subscription: @subscription,
      stripe_token: params[:stripe_token]
    )

    if ts.run
      render json: @subscription
    else
      render json: {error: ts.error}
    end
  end

  def unpause
    authorize! :update, @subscription

    ts = TransactionScripts::Subscription::Unpause.new(
      subscription: @subscription,
      medical_profile_params: medical_profile
    )

    if ts.run
      render json: @subscription
    else
      render json: {error: ts.error}
    end
  end

  def cancel
    authorize! :update, @subscription

    ts = TransactionScripts::Subscription::Cancel.new(subscription: @subscription)

    if ts.run
      render json: @subscription
    else
      render json: {error: ts.error}
    end
  end

  def add_payment_source
    authorize! :update, @subscription

    ts = TransactionScripts::Subscription::AddPaymentSource.new(
      subscription: @subscription,
      stripe_token: params[:stripe_token]
    )

    if ts.run
      render json: @subscription
    else
      render json: {error: ts.error}
    end
  end

  def apply_code
    authorize! :apply_code, @subscription

    ts = TransactionScripts::Subscription::ApplyCode.new(
      subscription: @subscription,
      code: params[:code]
    )

    if ts.run
      render json: @subscription
    else
      render json: {error: ts.error}
    end
  end

  private def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  private def medical_profile
    params.permit(
      :is_pregnant,
      :is_breast_feeding
    )
  end
end
