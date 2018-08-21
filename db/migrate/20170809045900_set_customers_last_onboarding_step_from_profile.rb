class SetCustomersLastOnboardingStepFromProfile < ActiveRecord::Migration[5.0]
  def change
    Customer.find_each do |customer|
      last_onboarding_step = 4
      last_onboarding_step = 3 if customer.city.nil?
      last_onboarding_step = 1 if customer.sex.nil?

      customer.update!(last_onboarding_step: last_onboarding_step)
    end
  end
end
