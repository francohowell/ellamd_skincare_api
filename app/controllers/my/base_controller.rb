module My
  class BaseController < ApplicationController
    def current_customer
      return @current_customer if @current_customer

      @current_customer = current_identity.user
      raise Errors::NotAuthorizedError unless @current_customer.is_a?(Customer)
      @current_customer
    end
  end
end
