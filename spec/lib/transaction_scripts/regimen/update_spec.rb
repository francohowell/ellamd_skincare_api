require "rails_helper"

describe TransactionScripts::Regimen::Update do
  let(:ben_raspail) { customers(:ben_raspail) }
  let(:ben_raspail_actual_regimen) { regimens(:ben_raspail_actual_regimen) }

  let(:ellamd_formulation) { products(:ellamd_formulation) }
  let(:good_genes_acid_treatment) { products(:good_genes_acid_treatment) }
  let(:drunk_elephant_eye_cream) { products(:drunk_elephant_eye_cream) }

  describe "#run" do
    it "updates Regimen, its RegimenProducts and creates Products when necessary" do
      expect(ben_raspail_actual_regimen.products).to contain_exactly(
        ellamd_formulation,
        good_genes_acid_treatment
      )

      ts = TransactionScripts::Regimen::Update.new(
        regimen: ben_raspail_actual_regimen,
        regimen_params: {
          regimen_products: [
            {
              period: "am",
              position: 0,
              product: {id: drunk_elephant_eye_cream.id, name: "Zzz"}
            },
            {
              period: "am",
              position: 1,
              product: {id: ellamd_formulation.id, name: "Zzz"}
            },
            {
              period: "am",
              position: 2,
              product: {name: "New product..."}
            }
          ]
        }
      )

      expect {
        ts.run
      }.to change{ Product.count }.by(1)

      new_product = Product.last
      expect(new_product.name).to eq("New product...")

      ben_raspail_actual_regimen.reload
      expect(ben_raspail_actual_regimen.products).to contain_exactly(
        drunk_elephant_eye_cream,
        ellamd_formulation,
        new_product
      )
    end
  end
end
