class NormalizeExistingPhoneNumbers < ActiveRecord::Migration[5.0]
  def change
    Customer.find_each do |customer|
      customer.update!(phone: PhonyRails.normalize_number(customer.phone))
    end
  end
end
