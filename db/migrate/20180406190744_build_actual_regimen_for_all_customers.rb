class BuildActualRegimenForAllCustomers < ActiveRecord::Migration[5.1]
  def change
    Customer.find_each do |customer|
      customer.regimens.build
      customer.save!
    end
  end
end
