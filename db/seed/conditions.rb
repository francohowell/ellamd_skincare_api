##
# Create the initial Conditions in our database.
Condition.create!(
  name: "Acne",
  description: "Acne is an inflammatory disorder typically caused" \
    "by plugged oil glands and P. acnes bacteria and results in whiteheads, " \
    "blackheads, pimples, cysts, and sometimes scarring"
)

Condition.create!(
  name: "Dermatitis",
  description: "Eczema, or atopic dermatitis, is a condition in which the skin barrier is compromised. " \
    "Skin dries out easily and is prone to inflammation. Good skin care is paramount."
)

Condition.create!(
  name: "Rosacea (Erythema)",
  description: "Erythemato-telangiectatic rosacea is a condition in which " \
    "skin stays red and small blood vessels form." \
    " Risk factors include genetics, sun, and frequent flushing."
)

Condition.create!(
  name: "Rosacea (Inflammatory)",
  description: "Inflammatory rosacea can look like acne with pimples and pustules. " \
    "Common triggers include anything that causes flushing (heat, alcohol), as well as stress and sun."
)

Condition.create!(
  name: "Lentigines",
  description: "Lentigines, or sunspots are caused by UV damage, " \
    "and typically occur in skin with fair to medium tones. " \
    "Sun protection is key, but certain compounds and procedures can fade them."
)

Condition.create!(
  name: "Melasma",
  description: "Melasma is a condition in which brown to gray patches appear, " \
    "usually on the cheeks or forehead. It is caused by an interaction between hormones, " \
    "sun, visible light, and the skin."
)

Condition.create!(
  name: "Periorbital Edema/Hyperpigmentation",
  description: "Periorbital edema (swelling) and hyperpigmentation (darkening) can be caused by " \
    "several conditions. Treatment is difficult and is directed at the root cause, " \
    "such as sinus congestion or inflamed skin."
)

Condition.create!(
  name: "Post-Inflammatory Hyperpigmentation",
  description: "Post-inflammatory hyperpigmentation usually occurs in skin with medium to darker tones. "\
    "More severe inflammation (from acne, eczema, etc.) and sun are risk factors."
)

Condition.create!(
  name: "Rhytides",
  description: "Rhytides, or wrinkles can be fixed (appear on the face at rest) or dynamic " \
    "(appear with facial expression). Smoking and UV damage accelerate the development of wrinkles."
)

Condition.create!(
  name: "Seborrheic Dermatitis",
  description: "Seborrheic dermatitis is a condition in which the skin’s immune system " \
    "reacts to yeast on the skin. Symptoms include redness and scaling on the face’s t-zone and the scalp."
)

Condition.create!(
  name: "Textural Irregularities",
  description: "Textural irregularity is skin that does not look or feel smooth. " \
    "Causes are numerous but include milia (tiny cysts) and sebaceous hyperplasia (overgrown oil glands)"
)

Condition.create!(
  name: "Xerosis",
  description: "Xerosis is the medical term for dry skin. A genetic tendency, dry climate, " \
    "and aggressive hygiene habits are common triggers. Good skin care can help immensely."
)
