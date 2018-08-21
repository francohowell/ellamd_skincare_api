class CreateProfiles < ActiveRecord::Migration[5.0]
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def change
    create_table :profiles do |t|
      t.references :customer, foreign_key: true
      t.string :sex
      t.string :address_line_1
      t.string :address_line_2
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :phone
      t.datetime :date_of_birth
      t.string :skin_concerns, array: true, null: false, default: []
      t.string :ethnicity
      t.float :sun_sensitivity
      t.integer :sun_exposure_in_minutes_per_day
      t.string :skin_type
      t.string :known_allergies
      t.boolean :smoker
      t.boolean :been_on_accutane
      t.boolean :hormonal_issues
      t.boolean :pregnant
      t.boolean :breast_feeding
      t.boolean :birth_control
      t.text :other_concerns
      t.text :topical_medications
      t.text :prescription_medications

      t.timestamps
    end
  end
end
