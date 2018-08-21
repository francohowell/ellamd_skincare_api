class AllowNullsOnSkinConcerns < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :skin_concerns, :string, array: true, null: true, default: nil

    Customer.find_each do |customer|
      customer.update!(skin_concerns: nil) if customer.skin_concerns.blank?
    end
  end
end
