module My
  class RegimensController < BaseController
    def update
      ts = TransactionScripts::Regimen::Update.new(
        regimen: regimen,
        regimen_params: params[:regimen]
      )

      if ts.run
        render json: regimen
      else
        render json: {error: regimen.error}
      end
    end

    private def regimen
      current_customer.actual_regimen
    end
  end
end
