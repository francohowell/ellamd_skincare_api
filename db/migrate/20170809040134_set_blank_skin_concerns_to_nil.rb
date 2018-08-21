class SetBlankSkinConcernsToNil < ActiveRecord::Migration[5.0]
  def change
    Customer.find_each do |customer|
      customer.update!(skin_concerns: nil) if customer.skin_concerns&.empty?
    end
  end
end
