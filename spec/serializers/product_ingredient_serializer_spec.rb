# == Schema Information
#
# Table name: product_ingredients
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  origin_id  :integer
#  is_key     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

describe ProductIngredientSerializer do
  let(:water) { product_ingredients(:water) }

  it "successfully renders ProductIngredient as json" do
    result = JSON.parse(ProductIngredientSerializer.new(water).to_json)

    expect(result["id"]).to be_present
    expect(result["name"]).to be_present
  end
end
