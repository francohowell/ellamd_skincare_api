class CreateMedicalProfiles < ActiveRecord::Migration[5.0]
  def up
    create_table :medical_profiles do |t|
      t.integer :customer_id, null: false

      t.integer  :sex, size: 2
      t.datetime :date_of_birth

      t.text :is_smoker
      t.text :is_pregnant
      t.text :is_breast_feeding
      t.text :is_on_birth_control
      t.text :known_allergies
      t.text :current_prescription_oral_medications
      t.text :current_prescription_topical_medications
      t.text :current_nonprescription_topical_medications
      t.text :past_prescription_oral_medications
      t.text :past_prescription_topical_medications
      t.text :past_nonprescription_topical_medications
      t.text :using_peels
      t.text :using_retinol
      t.text :has_been_on_accutane
      t.text :has_hormonal_issues
      t.text :other_concerns

      t.integer :preferred_fragrance, size: 2
      t.integer :skin_type,           size: 2
      t.jsonb   :skin_concerns

      t.integer :sunscreen_frequency, size: 2
      t.string  :sunscreen_brand

      t.string :user_skin_extra_details

      t.timestamps
    end

    execute <<~SQL
      ALTER TABLE medical_profiles
        ADD CONSTRAINT medical_profiles_customer_id_fkey
        FOREIGN KEY (customer_id) REFERENCES customers(id)
        ON DELETE CASCADE;

      CREATE INDEX index_medical_profiles_on_customer_id
        ON medical_profiles (customer_id);
    SQL

    Customer.find_each do |customer|
      mp = customer.build_medical_profile

      mp.sex = customer.sex
      mp.date_of_birth = customer.date_of_birth

      mp.is_smoker = customer.is_smoker
      mp.is_pregnant = customer.is_pregnant
      mp.is_breast_feeding = customer.is_breast_feeding
      mp.is_on_birth_control = customer.is_on_birth_control
      mp.known_allergies = customer.known_allergies
      mp.current_prescription_oral_medications = customer.current_prescription_oral_medications
      mp.current_prescription_topical_medications = customer.current_prescription_topical_medications
      mp.current_nonprescription_topical_medications = customer.current_nonprescription_topical_medications
      mp.past_prescription_oral_medications = customer.past_prescription_oral_medications
      mp.past_prescription_topical_medications = customer.past_prescription_topical_medications
      mp.past_nonprescription_topical_medications = customer.past_nonprescription_topical_medications
      mp.using_peels = customer.using_peels
      mp.using_retinol = customer.using_retinol
      mp.has_been_on_accutane = customer.has_been_on_accutane
      mp.has_hormonal_issues = customer.has_hormonal_issues
      mp.other_concerns = customer.other_concerns

      mp.preferred_fragrance = customer.preferred_fragrance
      mp.skin_type = customer.skin_type
      mp.skin_concerns = customer.skin_concerns
      mp.sunscreen_frequency = customer.sunscreen_frequency
      mp.sunscreen_brand = customer.sunscreen_brand
      mp.user_skin_extra_details = customer.user_skin_extra_details

      mp.save!
    end

    remove_column :customers, :sex
    remove_column :customers, :date_of_birth
    remove_column :customers, :is_smoker
    remove_column :customers, :is_pregnant
    remove_column :customers, :is_breast_feeding
    remove_column :customers, :is_on_birth_control
    remove_column :customers, :known_allergies
    remove_column :customers, :current_prescription_oral_medications
    remove_column :customers, :current_prescription_topical_medications
    remove_column :customers, :current_nonprescription_topical_medications
    remove_column :customers, :past_prescription_oral_medications
    remove_column :customers, :past_prescription_topical_medications
    remove_column :customers, :past_nonprescription_topical_medications
    remove_column :customers, :using_peels
    remove_column :customers, :using_retinol
    remove_column :customers, :has_been_on_accutane
    remove_column :customers, :has_hormonal_issues
    remove_column :customers, :other_concerns
    remove_column :customers, :preferred_fragrance
    remove_column :customers, :skin_type
    remove_column :customers, :skin_concerns
    remove_column :customers, :sunscreen_frequency
    remove_column :customers, :sunscreen_brand
    remove_column :customers, :user_skin_extra_details
  end
end

