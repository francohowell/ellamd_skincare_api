# == Schema Information
#
# Table name: regimen_products
#
#  id         :integer          not null, primary key
#  regimen_id :integer          not null
#  product_id :integer          not null
#  period     :integer          not null
#  position   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

describe RegimenProduct do
  let(:ben_raspail) { customers(:ben_raspail) }
  let(:ben_regimen) { FactoryBot.create(:regimen, customer: ben_raspail) }
  let(:good_genes_acid_treatment) { products(:good_genes_acid_treatment) }

  describe "validations" do
    it "is valid and saveable with valid attributes" do
      regimen_product = FactoryBot.build(
        :regimen_product,
        product: good_genes_acid_treatment,
        period: :am,
        position: 0
      )

      expect {
        ben_regimen.regimen_products << regimen_product
      }.to change{ RegimenProduct.count }.by(1)
    end
  end
end
