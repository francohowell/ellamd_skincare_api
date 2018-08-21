Bundler.require
require File.expand_path("../../../config/environment", __FILE__)

# rubocop:disable Metrics/MethodLength, Layout/EmptyLines
def create_customer(number:, created_at:)
  identity = Identity.create!(
    created_at: created_at,
    email: "customer+#{number}@ellamd.com",
    first_name: "Dora",
    last_name: "Hare",
    password: "password",
    user: Customer.create!(
      physician: Physician.first,
      sex: "female",
      address_line_1: "397 Libby Street",
      address_line_2: "Apt 2",
      zip_code: "90210",
      state: "CA",
      city: "Beverly Hills",
      date_of_birth: Date.new(1988, 4, 15),
      skin_concerns: ["acne", "sun spots"],
      skin_type: 3,
      last_onboarding_step: 4,
      created_at: created_at
    ),
  )

  customer = identity.user
  customer.visits.destroy_all

  customer
end

def create_prescription(visit:, created_at:, fulfilled_at: nil, tracking_number: nil)
  visit.create_diagnosis!(
    created_at: created_at,
    physician: Physician.first,
    conditions: Condition.where(name: ["Lentigines", "Rhytides", "Acne"]),
    note:
      "There is some minor scarring. Sun spots seem to be fading, but hydration is still needed.",
  )

  visit.create_prescription!(
    created_at: created_at,
    fulfilled_at: fulfilled_at,
    tracking_number: tracking_number,
    physician: Physician.first,
    signa: "Apply 2 pumps squeezes or .5ml to entire face every night at bedtime, " \
      "ideally 15 minutes after washing face.",
    customer_instructions: "Below you will find your diagnosis and treament plan. I’ll ask that " \
      "you please be patient with your results and expect the changes to be subtle within the " \
      "first month. Over a period of about 3-4 months, I would expect your skin pigmentation, " \
      "texture, and luster to continue to improve. If you have questions or concerns, please " \
      "reach out to me, as I am happy to help.",
    pharmacist_instructions: "Mix well.",
    cream_base: "hrt",
    fragrance: "no_scent",
    prescription_ingredients: Formulation.find_by(number: 3).formulation_ingredients.map do |fi|
      PrescriptionIngredient.new(
        ingredient: fi.ingredient,
        amount: fi.amount,
      )
    end,
  )
end
# rubocop:enable Metrics/MethodLength


######################################
# Customer 1: one visit "needs photos"

customer = create_customer(number: 1, created_at: 40.days.ago)

customer.visits.create!(created_at: 5.days.ago)

######################################
# Customer 2: one visit "needs prescription credit"

customer = create_customer(number: 2, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

customer.visits.create!(created_at: 5.days.ago)

######################################
# Customer 3: one visit "needs prescription"

customer = create_customer(number: 3, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

customer.visits.create!(created_at: 5.days.ago)

######################################
# Customer 4: one visit "needs fulfillment credit"

customer = create_customer(number: 4, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 5.days.ago)
create_prescription(visit: visit, created_at: 5.days.ago)

######################################
# Customer 5: one visit "needs fulfillment"

customer = create_customer(number: 5, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 5.days.ago)
create_prescription(visit: visit, created_at: 5.days.ago)

######################################
# Customer 6: one visit "needs tracking"

customer = create_customer(number: 6, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 5.days.ago)
create_prescription(visit: visit, created_at: 5.days.ago, fulfilled_at: 5.days.ago)

######################################
# Customer 7: one visits "done"

customer = create_customer(number: 7, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 5.days.ago)
create_prescription(visit: visit, created_at: 5.days.ago, fulfilled_at: 5.days.ago,
                    tracking_number: "456")

######################################
# Customer 8: one visit "done", one visit "needs photos"

customer = create_customer(number: 8, created_at: 40.days.ago)
visit = customer.visits.create!(created_at: 55.days.ago)
create_prescription(visit: visit, created_at: 55.days.ago, fulfilled_at: 55.days.ago,
                    tracking_number: "123")

customer.visits.create!(created_at: 5.days.ago)

######################################
# Customer 9: one visit "done", one visit "needs prescription credit"

customer = create_customer(number: 9, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 55.days.ago)
create_prescription(visit: visit, created_at: 55.days.ago, fulfilled_at: 55.days.ago,
                    tracking_number: "123")

customer.visits.create!(created_at: 5.days.ago)

######################################
# Customer 10: one visit "done", one visit "needs prescription"

customer = create_customer(number: 10, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 55.days.ago)
create_prescription(visit: visit, created_at: 55.days.ago, fulfilled_at: 55.days.ago,
                    tracking_number: "123")

customer.visits.create!(created_at: 5.days.ago)

######################################
# Customer 11: one visit "done", one visit "needs fulfillment credit"

customer = create_customer(number: 11, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 55.days.ago)
create_prescription(visit: visit, created_at: 55.days.ago, fulfilled_at: 55.days.ago,
                    tracking_number: "123")

visit = customer.visits.create!(created_at: 5.days.ago)
create_prescription(visit: visit, created_at: 5.days.ago)

######################################
# Customer 12: one visit "done", one visit "needs fulfillment"

customer = create_customer(number: 12, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 55.days.ago)
create_prescription(visit: visit, created_at: 55.days.ago, fulfilled_at: 55.days.ago,
                    tracking_number: "123")

visit = customer.visits.create!(created_at: 5.days.ago)
create_prescription(visit: visit, created_at: 5.days.ago)

######################################
# Customer 13: one visit "done", one visit "needs tracking"

customer = create_customer(number: 13, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 55.days.ago)
create_prescription(visit: visit, created_at: 55.days.ago, fulfilled_at: 55.days.ago,
                    tracking_number: "123")

visit = customer.visits.create!(created_at: 5.days.ago)
create_prescription(visit: visit, created_at: 5.days.ago, fulfilled_at: 5.days.ago)

######################################
# Customer 14: two visits "done"

customer = create_customer(number: 14, created_at: 40.days.ago)
customer.photos.create!(image: File.open(Rails.root.join("data", "patrick_blake_signature.png")))

visit = customer.visits.create!(created_at: 55.days.ago)
create_prescription(visit: visit, created_at: 55.days.ago, fulfilled_at: 55.days.ago,
                    tracking_number: "123")

visit = customer.visits.create!(created_at: 5.days.ago)
create_prescription(visit: visit, created_at: 5.days.ago, fulfilled_at: 5.days.ago,
                    tracking_number: "456")
