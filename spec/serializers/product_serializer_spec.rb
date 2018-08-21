# == Schema Information
#
# Table name: products
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  store             :integer          not null
#  origin_id         :integer
#  image_url         :string
#  product_url       :string
#  description       :text
#  diagnoses         :text
#  instructions      :text
#  tags              :jsonb
#  packages          :jsonb
#  average_rating    :float
#  number_of_reviews :integer
#  raw               :jsonb
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  brand             :string
#  store_id          :string
#  is_pending        :boolean          default(FALSE), not null
#

require "rails_helper"

describe ProductSerializer do
  let(:product) { products(:good_genes_acid_treatment) }

  it "successfully renders Product as json" do
    result = serialize(product)

    expect(result["id"]).to be_present
    expect(result["product-ingredients"]).to be_present
  end
end
