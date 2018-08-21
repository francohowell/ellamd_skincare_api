class PopulateVisits < ActiveRecord::Migration[5.0]
  class Customer < ApplicationRecord
    has_many :diagnoses
    has_many :photos
    has_many :visits
    has_many :prescriptions
  end

  class Prescription < ApplicationRecord
    belongs_to :customer
    belongs_to :visit
  end

  class Diagnosis < ApplicationRecord
    belongs_to :customer
    belongs_to :visit

    has_many :diagnosis_conditions, dependent: :destroy
  end

  def change
    Prescription.reset_column_information
    Diagnosis.reset_column_information

    Customer.find_each do |customer|
      create_prescription_based_visits(customer)
      remove_stray_visits(customer)
      create_initial_visit_if_none_exist(customer)
    end
  end

  ##
  # Create Prescription-based Visits and assign Diagnoses, and Photos
  private def create_prescription_based_visits(customer)
    customer.prescriptions.order(created_at: :asc).find_each do |prescription|
      diagnosis = customer.diagnoses
        .order(created_at: :desc)
        .where("created_at < ?", prescription.created_at + 15.minutes)
        .where(visit: nil)
        .first

      photos = customer.photos
        .order(created_at: :desc)
        .where("created_at < ?", prescription.created_at)
        .where(visit: nil)

      visit = customer.visits.create!(created_at: prescription.created_at)

      prescription.update!(visit: visit)
      diagnosis.try { update!(visit: visit) }
      photos.each { |photo| photo.update!(visit: visit) }

      visit.update!(created_at: photos.first.created_at) if photos.any?
    end
  end

  ##
  # Remove diagnoses that aren't associated with a Visit
  private def remove_stray_visits(customer)
    customer.diagnoses.where(visit: nil).destroy_all
  end

  ##
  # For Customers with no Photos or Prescriptions, we create an initial, empty Visit
  private def create_initial_visit_if_none_exist(customer)
    return if customer.visits.any?
    customer.visits.create!
  end
end
