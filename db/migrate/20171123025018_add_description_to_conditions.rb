class AddDescriptionToConditions < ActiveRecord::Migration[5.0]
  def change
    add_column :conditions, :description, :text
    add_column :diagnosis_conditions, :description, :text

    conditions_description = {
      "Acne" => "Acne is an inflammatory disorder typically caused" \
        "by plugged oil glands and P. acnes bacteria and results in whiteheads, " \
        "blackheads, pimples, cysts, and sometimes scarring",
      "Dermatitis" => "Eczema, or atopic dermatitis, is a condition in which the skin barrier is compromised. " \
        "Skin dries out easily and is prone to inflammation. Good skin care is paramount.",
      "Rosacea (Erythema)" => "Erythemato-telangiectatic rosacea is a condition in which " \
        "skin stays red and small blood vessels form. " \
        "Risk factors include genetics, sun, and frequent flushing.",
      "Rosacea (Inflammatory)" => "Inflammatory rosacea can look like acne with pimples and pustules. " \
        "Common triggers include anything that causes flushing (heat, alcohol), as well as stress and sun.",
      "Lentigines" => "Lentigines, or sunspots are caused by UV damage, " \
        "and typically occur in skin with fair to medium tones. " \
        "Sun protection is key, but certain compounds and procedures can fade them.",
      "Melasma" => "Melasma is a condition in which brown to gray patches appear, " \
        "usually on the cheeks or forehead. It is caused by an interaction between hormones, " \
        "sun, visible light, and the skin.",
      "Periorbital Edema/Hyperpigmentation" => "Periorbital edema (swelling) and hyperpigmentation (darkening) can be caused by " \
        "several conditions. Treatment is difficult and is directed at the root cause, " \
        "such as sinus congestion or inflamed skin.",
      "Post-Inflammatory Hyperpigmentation" => "Post-inflammatory hyperpigmentation usually occurs in skin with medium to darker tones. "\
        "More severe inflammation (from acne, eczema, etc.) and sun are risk factors.",
      "Rhytides" => "Rhytides, or wrinkles can be fixed (appear on the face at rest) or dynamic " \
        "(appear with facial expression). Smoking and UV damage accelerate the development of wrinkles.",
      "Seborrheic Dermatitis" => "Seborrheic dermatitis is a condition in which the skin’s immune system " \
        "reacts to yeast on the skin. Symptoms include redness and scaling on the face’s t-zone and the scalp.",
      "Textural Irregularities" => "Textural irregularity is skin that does not look or feel smooth. " \
        "Causes are numerous but include milia (tiny cysts) and sebaceous hyperplasia (overgrown oil glands)",
      "Xerosis" => "Xerosis is the medical term for dry skin. A genetic tendency, dry climate, " \
        "and aggressive hygiene habits are common triggers. Good skin care can help immensely."
    }

    Condition.all.each do |condition|
      condition.update(description: conditions_description[condition.name])
    end
  end
end
