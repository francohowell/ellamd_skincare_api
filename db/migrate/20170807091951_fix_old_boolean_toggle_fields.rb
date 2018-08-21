class FixOldBooleanToggleFields < ActiveRecord::Migration[5.0]
  def change
    boolean_to_text_columns = [
      :is_smoker,
      :has_been_on_accutane,
      :has_hormonal_issues,
      :is_pregnant,
      :is_breast_feeding,
      :is_on_birth_control,
    ]

    Customer.find_each do |customer|
      boolean_to_text_columns.each do |field|
        if customer[field] == "true"
          begin
            customer.update!(field => "")
          rescue ActiveRecord::RecordInvalid => _error
            customer.update!(field => "-")
          end
        elsif customer[field] == "false"
          customer.update!(field => nil)
        end
      end
    end
  end
end
