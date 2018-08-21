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

describe ProductIngredient do
  describe "validations" do
    it "is valid and saveable with valid attributes" do
      product_ingredient = FactoryBot.build(:product_ingredient)

      expect(product_ingredient).to be_valid
      expect(product_ingredient.save).to be_truthy
    end
  end
end
