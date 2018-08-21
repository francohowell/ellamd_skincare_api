##
# Create the initial Formulations in our database.

##
# Helper function to initialize a FormulationIngredient.
def initialize_formulation_ingredient(name, amount)
  FormulationIngredient.new(
    ingredient: Ingredient.find_by(name: name),
    amount: amount,
  )
end

Formulation.create!(
  number: 1,
  main_tag: "Acne – mild Inflammatory + mild PIH + melasma (Sensitive)",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Azelaic Acid", 10.00),
    initialize_formulation_ingredient("Sodium Sulfacetamide", 5.00),
    initialize_formulation_ingredient("Niacinamide", 2.00),
    initialize_formulation_ingredient("Tretinoin", 0.03),
  ],
)

Formulation.create!(
  number: 2,
  main_tag: "Acne – Inflammatory +++",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Benzoyl Peroxide", 4.00),
    initialize_formulation_ingredient("Niacinamide", 4.00),
    initialize_formulation_ingredient("Clindamycin", 1.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
  ],
)

Formulation.create!(
  number: 3,
  main_tag: "Acne – Comedonal + textural irregularities",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Hyaluronic Acid", 2.00),
    initialize_formulation_ingredient("Aloe", 2.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
    initialize_formulation_ingredient("Allantoin", 1.00),
    initialize_formulation_ingredient("Tretinoin", 0.05),
  ],
)

Formulation.create!(
  number: 4,
  main_tag: "Rhytides / Poikiloderma (sensitive)",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Niacinamide", 4.00),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 1.00),
    initialize_formulation_ingredient("Green Tea Extract", 1.00),
    initialize_formulation_ingredient("Tretinoin", 0.03),
  ],
)

Formulation.create!(
  number: 5,
  main_tag: "Rosacea / Baseline erythema",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Sodium Sulfacetamide", 5.00),
    initialize_formulation_ingredient("Niacinamide", 4.00),
    initialize_formulation_ingredient("Metronidazole", 1.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
  ],
)

Formulation.create!(
  number: 6,
  main_tag: "Lentigines 1",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Kojic Acid", 5.00),
    initialize_formulation_ingredient("Arbutin", 2.00),
    initialize_formulation_ingredient("Aloe", 2.00),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 1.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
    initialize_formulation_ingredient("Tretinoin", 0.05),
  ],
)

Formulation.create!(
  number: 7,
  main_tag: "Lentigines 2",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Hydroquinone", 4.00),
    initialize_formulation_ingredient("Tretinoin", 0.10),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
    initialize_formulation_ingredient("Hyaluronic Acid", 1.00),
    initialize_formulation_ingredient("Ascorbyl Palmitate", 2.00),
  ],
)

Formulation.create!(
  number: 8,
  main_tag: "Melasma",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Kojic Acid", 4.00),
    initialize_formulation_ingredient("Hydroquinone", 4.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
    initialize_formulation_ingredient("Tretinoin", 0.03),
  ],
)

Formulation.create!(
  number: 9,
  main_tag: "Melasma HQ Alternative ",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Azelaic Acid", 10.00),
    initialize_formulation_ingredient("Kojic Acid", 4.00),
    initialize_formulation_ingredient("Green Tea Extract", 2.00),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 1.00),
  ],
)

Formulation.create!(
  number: 10,
  main_tag: "Kiyoka Formula",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Niacinamide", 3.00),
    initialize_formulation_ingredient("Kojic Acid", 3.00),
    initialize_formulation_ingredient("Hydroquinone", 2.00),
    initialize_formulation_ingredient("Arnica", 2.00),
    initialize_formulation_ingredient("Ascorbic Acid", 2.00),
    initialize_formulation_ingredient("Hyaluronic Acid", 2.00),
    initialize_formulation_ingredient("Allantoin", 1.00),
    initialize_formulation_ingredient("Hydrocortisone", 0.50),
    initialize_formulation_ingredient("Tretinoin", 0.03),
  ],
)

Formulation.create!(
  number: 11,
  main_tag: "Nick Formula",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Ascorbic Acid", 5.00),
    initialize_formulation_ingredient("Niacinamide", 3.00),
    initialize_formulation_ingredient("Hyaluronic Acid", 2.00),
    initialize_formulation_ingredient("Tretinoin", 0.03),
  ],
)

Formulation.create!(
  number: 12,
  main_tag: "Alice Wu Formula",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Sodium Sulfacetamide", 5.00),
    initialize_formulation_ingredient("Azelaic Acid", 5.00),
    initialize_formulation_ingredient("Ascorbic Acid", 5.00),
    initialize_formulation_ingredient("Clindamycin", 1.00),
    initialize_formulation_ingredient("Hyaluronic Acid", 1.00),
    initialize_formulation_ingredient("Tretinoin", 0.05),
  ],
)

Formulation.create!(
  number: 20,
  main_tag: "Melasma",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Hydroquinone", 8.00),
    initialize_formulation_ingredient("Tretinoin", 0.03),
    initialize_formulation_ingredient("Hydrocortisone", 2.00),
    initialize_formulation_ingredient("Kojic Acid", 4.00),
  ],
)

Formulation.create!(
  number: 21,
  main_tag: "Anti-Aging",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Bisabolol", 0.50),
    initialize_formulation_ingredient("Chrysin", 3.00),
    initialize_formulation_ingredient("Vitamin K1", 0.50),
    initialize_formulation_ingredient("Ascorbyl Palmitate", 2.00),
    initialize_formulation_ingredient("Palmitoyl Pentapeptide-4", 3.00),
    initialize_formulation_ingredient("Coenzyme Q-10", 1.00),
    initialize_formulation_ingredient("Urea", 1.00),
  ],
)

Formulation.create!(
  number: 22,
  main_tag: "Anti-Aging",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Bisabolol", 0.50),
    initialize_formulation_ingredient("Vitamin K1", 0.50),
    initialize_formulation_ingredient("Ascorbyl Palmitate", 2.00),
    initialize_formulation_ingredient("Palmitoyl Pentapeptide-4", 3.00),
    initialize_formulation_ingredient("Estriol", 0.30),
    initialize_formulation_ingredient("Coenzyme Q-10", 1.00),
    initialize_formulation_ingredient("Niacinamide", 3.00),
    initialize_formulation_ingredient("Estradiol", 0.01),
  ],
)

Formulation.create!(
  number: 23,
  main_tag: "Seborrhea",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Sodium Sulfacetamide", 8.00),
    initialize_formulation_ingredient("Retinol", 3.00),
    initialize_formulation_ingredient("Niacinamide", 2.00),
    initialize_formulation_ingredient("Sulfur", 2.00),
    initialize_formulation_ingredient("Green Tea Extract", 1.00),
    initialize_formulation_ingredient("Tacrolimus", 0.10),
  ],
)

Formulation.create!(
  number: 27,
  main_tag: "Pseudofolliculitis",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Aloe", 2.00),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 2.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.50),
    initialize_formulation_ingredient("Clindamycin", 1.00),
    initialize_formulation_ingredient("Tretinoin", 0.05),
  ],
)

Formulation.create!(
  number: 29,
  main_tag: "Pityriasis Alba",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Alpha Lipoic Acid", 3.00),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 2.00),
    initialize_formulation_ingredient("Ascorbyl Palmitate", 2.00),
    initialize_formulation_ingredient("Green Tea Extract", 2.00),
    initialize_formulation_ingredient("Tacrolimus", 0.10),
    initialize_formulation_ingredient("Hydrocortisone", 2.00),
    initialize_formulation_ingredient("Bisabolol", 0.50),
  ],
)

Formulation.create!(
  number: 30,
  main_tag: "Acne - Pregnant",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Azelaic Acid", 10.00),
    initialize_formulation_ingredient("Niacinamide", 2.00),
    initialize_formulation_ingredient("Metronidazole", 0.75),
  ],
)

Formulation.create!(
  number: 31,
  main_tag: "PIH - Actively Inflamed",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Triamcinolone", 0.05),
    initialize_formulation_ingredient("Hydroquinone", 6.00),
    initialize_formulation_ingredient("Coenzyme Q-10", 1.00),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 2.00),
    initialize_formulation_ingredient("Green Tea Extract", 2.00),
  ],
)

Formulation.create!(
  number: 32,
  main_tag: "Xerosis / Eczema",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Tacrolimus", 0.10),
    initialize_formulation_ingredient("Hydrocortisone", 2.00),
    initialize_formulation_ingredient("Hyaluronic Acid", 2.00),
    initialize_formulation_ingredient("Palmitoyl Pentapeptide-4", 3.00),
    initialize_formulation_ingredient("Aloe", 2.00),
    initialize_formulation_ingredient("Allantoin", 2.00),
  ],
)

Formulation.create!(
  number: 33,
  main_tag: "Acne - Aggressive",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Sodium Sulfacetamide", 5.00),
    initialize_formulation_ingredient("Azelaic Acid", 5.00),
    initialize_formulation_ingredient("Clindamycin", 1.00),
    initialize_formulation_ingredient("Hyaluronic Acid", 1.00),
    initialize_formulation_ingredient("Tretinoin", 0.10),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
  ],
)

Formulation.create!(
  number: 34,
  main_tag: "Anti-Oxidant",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Alpha Lipoic Acid", 3.00),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 2.00),
    initialize_formulation_ingredient("Coenzyme Q-10", 1.00),
    initialize_formulation_ingredient("Green Tea Extract", 2.00),
    initialize_formulation_ingredient("Retinol", 3.00),
    initialize_formulation_ingredient("Niacinamide", 3.00),
  ],
)

Formulation.create!(
  number: 35,
  main_tag: "Anti-Aging",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Bisabolol", 0.50),
    initialize_formulation_ingredient("Chrysin", 3.00),
    initialize_formulation_ingredient("Ascorbyl Palmitate", 2.00),
    initialize_formulation_ingredient("Palmitoyl Pentapeptide-4", 3.00),
    initialize_formulation_ingredient("Coenzyme Q-10", 1.00),
    initialize_formulation_ingredient("Urea", 1.00),
    initialize_formulation_ingredient("Tretinoin", 0.03),
    initialize_formulation_ingredient("Niacinamide", 3.00),
  ],
)

Formulation.create!(
  number: 36,
  main_tag: "Anti-Aging",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Bisabolol", 0.50),
    initialize_formulation_ingredient("Spironolactone", 2.00),
    initialize_formulation_ingredient("Ascorbyl Palmitate", 2.00),
    initialize_formulation_ingredient("Palmitoyl Pentapeptide-4", 3.00),
    initialize_formulation_ingredient("Estriol", 0.30),
    initialize_formulation_ingredient("Coenzyme Q-10", 1.00),
    initialize_formulation_ingredient("Niacinamide", 3.00),
    initialize_formulation_ingredient("Estradiol", 0.01),
    initialize_formulation_ingredient("Tretinoin", 0.03),
  ],
)

Formulation.create!(
  number: 38,
  main_tag: "Unnamed 1",
  cream_base: "anhydrous",
  formulation_ingredients: [
    initialize_formulation_ingredient("Green Tea Extract", 1.00),
    initialize_formulation_ingredient("Niacinamide", 4.00),
    initialize_formulation_ingredient("Tretinoin", 0.03),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 1.00),
  ],
)

Formulation.create!(
  number: 39,
  main_tag: "Jessica Formula",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Azelaic Acid", 10.00),
    initialize_formulation_ingredient("Kojic Acid", 4.00),
    initialize_formulation_ingredient("Green Tea Extract", 2.00),
    initialize_formulation_ingredient("Alpha-Tocopherol (Vitamin E Acetate)", 1.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
  ],
)

Formulation.create!(
  number: 40,
  main_tag: "Melasma",
  cream_base: "anhydrous",
  formulation_ingredients: [
    initialize_formulation_ingredient("Hydroquinone", 8.00),
    initialize_formulation_ingredient("Tretinoin", 0.03),
    initialize_formulation_ingredient("Hydrocortisone", 2.00),
    initialize_formulation_ingredient("Kojic Acid", 4.00),
    initialize_formulation_ingredient("Alpha Lipoic Acid", 3.00),
  ],
)

Formulation.create!(
  number: 41,
  main_tag: "Rosacea",
  cream_base: "anhydrous",
  formulation_ingredients: [
    initialize_formulation_ingredient("Metronidazole", 1.00),
    initialize_formulation_ingredient("Niacinamide", 4.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
    initialize_formulation_ingredient("Azelaic Acid", 5.00),
  ],
)

Formulation.create!(
  number: 43,
  main_tag: "Keratosis Pilaris",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Aloe", 1.00),
    initialize_formulation_ingredient("Glycolic Acid", 6.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
    initialize_formulation_ingredient("Hyaluronic Acid", 2.00),
    initialize_formulation_ingredient("Allantoin", 1.00),
  ],
)

Formulation.create!(
  number: 44,
  main_tag: "Melasma",
  cream_base: "hrt",
  formulation_ingredients: [
    initialize_formulation_ingredient("Hydroquinone", 4.00),
    initialize_formulation_ingredient("Hydrocortisone", 1.00),
    initialize_formulation_ingredient("Kojic Acid", 4.00),
    initialize_formulation_ingredient("Alpha Lipoic Acid", 1.00),
    initialize_formulation_ingredient("Glycolic Acid", 5.00),
  ],
)

Formulation.create!(
  number: 47,
  main_tag: "Seborrhea",
  cream_base: "anhydrous",
  formulation_ingredients: [
    initialize_formulation_ingredient("Sulfur", 2.00),
    initialize_formulation_ingredient("Niacinamide", 3.00),
    initialize_formulation_ingredient("Ketoconazole", 2.00),
    initialize_formulation_ingredient("Green Tea Extract", 1.00),
    initialize_formulation_ingredient("Tacrolimus", 0.10),
  ],
)
