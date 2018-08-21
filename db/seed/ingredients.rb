##
# Create the initial Formulations in our database.
#
# rubocop:disable Metrics/LineLength, Metrics/ParameterLists

##
# Helper function to create an Ingredient.
def create_ingredient(
  name:,
  description: nil,
  classes: [],
  is_premium: false,
  is_prescription_required: false,
  minimum_amount: 0,
  maximum_amount: 10,
  unit: "%"
)
  ingredient = Ingredient.find_or_initialize_by(name: name)

  ingredient.description = description
  ingredient.classes = classes
  ingredient.is_premium = is_premium
  ingredient.is_prescription_required = is_prescription_required
  ingredient.minimum_amount = minimum_amount
  ingredient.maximum_amount = maximum_amount
  ingredient.unit = unit

  ingredient.save!
end

create_ingredient(name: "Allantoin", minimum_amount: 1, maximum_amount: 2, description: "Helps skin hydration and barrier function.", classes: ["Humectants"])

create_ingredient(name: "Aloe", minimum_amount: 1, maximum_amount: 2, description: "Reduces skin irritation and burn treatment.", classes: ["Anti-Inflammatories"], is_prescription_required: true)

create_ingredient(name: "Alpha Lipoic Acid", minimum_amount: 1, maximum_amount: 3, description: "An essential acid for cell metabolism and a potent anti-oxidant.", classes: ["Pigmentary Regulators", "Anti-Oxidants"], is_prescription_required: true)

create_ingredient(name: "Alpha-Tocopherol (Vitamin E Acetate)", minimum_amount: 1, maximum_amount: 2, description: "A natural antioxidant and anti inflammatory.", classes: ["Anti-Oxidants"], is_prescription_required: true)

create_ingredient(name: "Arbutin", minimum_amount: 2, maximum_amount: 4, description: "Naturally extracted from the Bearberry plant, helps prevent the formation of melanin and evens skin tone.", classes: ["Pigmentary Regulators"])

create_ingredient(name: "Arnica", minimum_amount: 2, maximum_amount: 5, description: "Plant extract that helps to prevent blood vessel leakage / undereye darkening.", classes: ["Anti-Ecchymotic"])

create_ingredient(name: "Ascorbic Acid", minimum_amount: 2, maximum_amount: 15, description: "Vitamin C, helps collagen synthesis, pigment evening, and stabilizing other ingredients.", classes: ["Pigmentary Regulators", "Anti-Oxidants"])

create_ingredient(name: "Ascorbyl Palmitate", minimum_amount: 0.5, maximum_amount: 2, description: "Vitamin C, helps collagen synthesis, pigment evening, and stabilizing other ingredients.", classes: ["Anti-Oxidants"])

create_ingredient(name: "Azelaic Acid", minimum_amount: 5, maximum_amount: 15, description: "Naturally produced by yeast. Reduces bacteria on the skin and inflammation, and regulates pigmentation.", classes: ["Anti-Inflammatories", "Pigmentary Regulators"])

create_ingredient(name: "Benzoyl Peroxide", minimum_amount: 2, maximum_amount: 5, description: "Behaves as an antimicrobial without inducing antibiotic resistance.", classes: ["Anti-Microbials"])

create_ingredient(name: "Bisabolol", minimum_amount: 0.25, maximum_amount: 1, description: "Derived from chamomile and sage, it assists the penetration of other ingredients and acts as an anti-inflammatory.", classes: ["Delivery Enhancers", "Anti-Inflammatories"], is_prescription_required: true)

create_ingredient(name: "Caffeine", minimum_amount: 0.5, maximum_amount: 2, description: "Quickly penetrates skin and reduces swelling; it is also an anti-oxidant.", classes: ["Anti-Inflammatory", "Vasoconstrictors"])

create_ingredient(name: "Chrysin", minimum_amount: 1, maximum_amount: 3, description: "Derived from passion flower, this flavonoid has potent anti-oxidant and anti-cancer activity.", classes: ["Anti-Oxidants", "Anti-Carcinogens"])

create_ingredient(name: "Clindamycin", minimum_amount: 0.5, maximum_amount: 1, description: "An antibiotic to stop growth of acne-causing bacteria like P. acnes and S. aureus.", classes: ["Antibiotics"], is_prescription_required: true)

create_ingredient(name: "Coenzyme Q-10", minimum_amount: 0.5, maximum_amount: 2, description: "An essential component of the body's metabolism, it helps the skin overcome injury and UV damage.", classes: ["Anti-Oxidants"])

create_ingredient(name: "Dimethicone", description: "Excellent for maintaining skin barrier function.", classes: ["Barriers"])

create_ingredient(name: "Estradiol", minimum_amount: 0.01, maximum_amount: 0.02, description: "A potent form of estrogen, which increases collagen, thus maintaining skin firmness and preventing wrinkles.", classes: ["Hormonal Modulators"], is_prescription_required: true)

create_ingredient(name: "Estriol", minimum_amount: 0.1, maximum_amount: 0.5, description: "A mild form of estrogen, best known for maintaining the “pregnancy glow”.", classes: ["Hormonal Modulators"])

create_ingredient(name: "Glycolic Acid", minimum_amount: 5, maximum_amount: 10, description: "Derived from sugar cane, this alpha-hydroxy acid brightens skin without causing peeling at low concentrations.", classes: ["Keratolytics", "Pigmentary Regulators"])

create_ingredient(name: "Green Tea Extract", minimum_amount: 1, maximum_amount: 2, description: "Derived from Camellia sinensis, rich in antioxidant as well as xanthines (molecules that promote circulation).", classes: ["Anti-Oxidants"], is_prescription_required: true)

create_ingredient(name: "Hyaluronic Acid", minimum_amount: 0.5, maximum_amount: 2, description: "The most important agent for skin fullness and hydration.", classes: ["Humectants"], is_prescription_required: true)

create_ingredient(name: "Hydrocortisone", minimum_amount: 0.5, maximum_amount: 2.5, description: "A mild anti-inflammatory steroid.", classes: ["Steroids"])

create_ingredient(name: "Hydroquinone", minimum_amount: 2, maximum_amount: 8, description: "Naturally found in Bearberry plants, greatly improves hyperpigmentation.", classes: ["Pigmentary Regulators"])

create_ingredient(name: "Ivermectin", minimum_amount: 0.5, maximum_amount: 1, description: "An anti-parasitic compound that targets Demodex around the hair follicles, reducing inflammation.", classes: ["Anti-Parasitic"], is_prescription_required: true, is_premium: true)

create_ingredient(name: "Ketoconazole", minimum_amount: 1, maximum_amount: 3, description: "An anti-fungal that targets nearly all of the problematic fungus on the skin.", classes: ["Anti-Fungal", "Anti-Inflammatories"])

create_ingredient(name: "Kojic Acid", minimum_amount: 2, maximum_amount: 5, description: "A product of sake formation, it prevents oxidative darkening.", classes: ["Keratolytics", "Pigmentary Regulators"])

create_ingredient(name: "Lactic Acid", minimum_amount: 5, maximum_amount: 10, description: "Alpha Hydroxy Acid (AHA) extracted from milk that helps exfoliate dead skin.", classes: ["Humectants"])

create_ingredient(name: "Metronidazole", minimum_amount: 0.5, maximum_amount: 1, description: "Decreases redness, swelling and the number of pimples caused by rosacea and acne.", classes: ["Antibiotics"], is_prescription_required: true)

create_ingredient(name: "Niacinamide", minimum_amount: 2, maximum_amount: 4, description: "Vitamin B3- improves inflammation, hydrates skin, and helps prevent skin cancer.", classes: ["Anti-Inflammatories", "Anti-Carcinogens"])

create_ingredient(name: "Oxymetazoline", minimum_amount: 0.5, maximum_amount: 2, description: "Stops over-dilation of blood vessels, reducing swelling and redness.", classes: ["Vasoconstrictors"], is_prescription_required: true, is_premium: true)

create_ingredient(name: "Palmitoyl Pentapeptide-4", minimum_amount: 1, maximum_amount: 5, description: "A messenger peptide that tells cells to produce a stronger matrix (more collagen).", classes: ["Collagenesis Upregulator"], is_prescription_required: true, is_premium: true)

create_ingredient(name: "Retinol", minimum_amount: 0.1, maximum_amount: 3, description: "Vitamin A derivative. Important for skin cancer prevention, thickening of the epidermis, regulation of oil glands, collagen synthesis, and exfoliating dead skin cells. Less aggressive than other retinoids such as tretinoin.", classes: ["Retinoids"], is_prescription_required: true)

create_ingredient(name: "Sodium Sulfacetamide", minimum_amount: 2.5, maximum_amount: 10, description: "A potent anti-inflammatory and also reduces bacterial growth.", classes: ["Anti-Microbials", "Anti-Inflammatories"])

create_ingredient(name: "Spironolactone", minimum_amount: 2, maximum_amount: 5, description: "Effective in the treatment of hormonal acne.", classes: ["Hormonal Modulators"], is_prescription_required: true)

create_ingredient(name: "Sulfur", minimum_amount: 2, maximum_amount: 4, description: "A potent anti-inflammatory and also reduces bacterial growth.", classes: ["Anti-Inflammatories"])

create_ingredient(name: "Tacrolimus", minimum_amount: 0.03, maximum_amount: 0.1, description: "A potent non-steroidal anti-inflammatory.", classes: ["Anti-Inflammatories"])

create_ingredient(name: "Tretinoin", minimum_amount: 0.01, maximum_amount: 0.1, description: "Vitamin A derivative. Important for skin cancer prevention, thickening of the epidermis, regulation of oil glands, collagen synthesis, and exfoliating dead skin cells.", classes: ["Retinoids", "Anti-Carcinogens"])

create_ingredient(name: "Triamcinolone", minimum_amount: 0.025, maximum_amount: 2, description: "A mid-strength anti-inflammatory steroid.", classes: ["Steroid"])

create_ingredient(name: "Urea", minimum_amount: 1, maximum_amount: 5, description: "Created when the body breaks down proteins, helps to maintain skin hydration and pH balance.", classes: ["Humectant"])

create_ingredient(name: "Vitamin K1", minimum_amount: 0.25, maximum_amount: 1, description: "Active Vitamin K, an essential co-factor for blood clotting.", classes: ["Anti-Ecchymotic"])

create_ingredient(name: "Zinc Oxide", minimum_amount: 5, maximum_amount: 10, classes: ["Barriers"])
