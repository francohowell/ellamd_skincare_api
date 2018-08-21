module My
  class MedicalProfileAuditsController < BaseController
    def index
      audits = current_customer.medical_profile.audits.updates
      render json: audits
    end
  end
end
