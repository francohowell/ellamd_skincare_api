##
# Concern to initialize certain objects from their identifiers in `params`.
#
# These methods are included on ApplicationController (and any sub-controllers) and are designed
# to be called via `before_action`. They set corresponding instance variables to be used within
# actions.
module SetObjectsFromParams
  extend ActiveSupport::Concern

  protected def set_customer_from_params
    @customer = Customer.find(params[:customer_id])
  end

  protected def set_prescription_from_params
    if params[:prescription_id]
      @prescription = Prescription.find(params[:prescription_id])
    elsif params[:prescription_token]
      @prescription = Prescription.find_by!(token: params[:prescription_token])
    end
  end

  protected def set_visit_from_params
    @visit = Visit.find(params[:visit_id])
  end
end
