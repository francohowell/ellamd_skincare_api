##
# Create our initial users.
#
# TODO: This data is not actually used on production, and shouldn't really live in a seed file like
#   this anyway. It's used mostly for development setup and demonstrations.
Identity.create!(
  email: "administrator@ellamd.com",
  first_name: "Jeremy",
  last_name: "Carr",
  password: "password",
  user: Administrator.create!,
)

Identity.create!(
  email: "drblake@ellamd.com",
  first_name: "Patrick",
  last_name: "Blake",
  password: "password",
  user: Physician.create!(
    state_license: "A130951",
    dea_license: "FB4682185",
    address: "4022 Lamont St\nUnit 1\nSan Diego, CA 92109",
    phone: "858-375-3653",
    signature_image: File.open(Rails.root.join("data", "patrick_blake_signature.png")),
  ),
)

Identity.create!(
  email: "pharmacist@ellamd.com",
  first_name: "Jeremy",
  last_name: "Carr",
  password: "password",
  user: Pharmacist.create!,
)

Identity.create!(
  email: "customer@ellamd.com",
  first_name: "Dora",
  last_name: "Hare",
  password: "password",
  user: Customer.create!(
    created_at: 3.hours.ago,
    physician: Physician.first,
    sex: "female",
    address_line_1: "397 Libby Street",
    address_line_2: "Apt 2",
    zip_code: "90210",
    state: "CA",
    city: "Beverly Hills",
    phone: "310-278-1591",
    date_of_birth: Date.new(1988, 4, 15),
    skin_concerns: ["acne", "sun spots"],
    skin_type: 3,
    known_allergies: "Penicillin",
    is_smoker: false,
    has_been_on_accutane: false,
    has_hormonal_issues: false,
    is_pregnant: false,
    is_breast_feeding: false,
    is_on_birth_control: false,
    other_concerns: nil,
    topical_medications: nil,
    prescription_medications: "Lipitor",
  ),
)

Diagnosis.create!(
  created_at: 2.hours.ago,
  customer: Customer.first,
  physician: Physician.first,
  conditions: Condition.where(name: ["Lentigines", "Rhytides", "Acne"]),
  note: "There is some minor scarring. Sun spots seem to be fading, but hydration is still needed.",
)

Prescription.create!(
  created_at: 2.hours.ago,
  customer: Customer.first,
  physician: Physician.first,
  signa: "Apply 2 pumps squeezes or .5ml to entire face every night at bedtime, " \
    "ideally 15 minutes after washing face.",
  customer_instructions: "Below you will find your diagnosis and treament plan. I’ll ask that " \
    "you please be patient with your results and expect the changes to be subtle within the " \
    "first month. Over a period of about 3-4 months, I would expect your skin pigmentation, " \
    "texture, and luster to continue to improve. If you have questions or concerns, please reach " \
    "out to me, as I am happy to help.",
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
