class MoveProfileFieldsToCustomer < ActiveRecord::Migration[5.0]
  def change
    replace_non_california_profiles
    add_customer_columns
    populate_customer_columns
  end

  def replace_non_california_profiles
    # rubocop:disable Rails/SkipsModelValidations
    Profile.update_all(state: "CA")
    # rubocop:enable Rails/SkipsModelValidations
  end

  def add_customer_columns
    add_column :customers, :sex, :string
    add_column :customers, :address_line_1, :string
    add_column :customers, :address_line_2, :string
    add_column :customers, :zip_code, :string
    add_column :customers, :state, :string
    add_column :customers, :city, :string
    add_column :customers, :phone, :string
    add_column :customers, :preferred_fragrance, :string
    add_column :customers, :date_of_birth, :datetime
    add_column :customers, :skin_concerns, :string, default: [], null: false, array: true
    add_column :customers, :skin_type, :integer
    add_column :customers, :smoker, :boolean
    add_column :customers, :been_on_accutane, :boolean
    add_column :customers, :hormonal_issues, :boolean
    add_column :customers, :pregnant, :boolean
    add_column :customers, :breast_feeding, :boolean
    add_column :customers, :birth_control, :boolean
    add_column :customers, :other_concerns, :text
    add_column :customers, :topical_medications, :text
    add_column :customers, :prescription_medications, :text
    add_column :customers, :known_allergies, :text
  end

  def populate_customer_columns
    fields = %i[
      sex address_line_1 address_line_2 zip_code state city phone date_of_birth
      skin_concerns known_allergies smoker been_on_accutane hormonal_issues pregnant breast_feeding
      birth_control other_concerns topical_medications prescription_medications skin_type
      preferred_fragrance
    ]

    Profile.find_each do |profile|
      customer = profile.customer

      fields.each do |field|
        customer[field] = profile[field]
      end

      customer.save!
    end
  end
end
