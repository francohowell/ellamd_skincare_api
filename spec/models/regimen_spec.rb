# == Schema Information
#
# Table name: regimens
#
#  id           :integer          not null, primary key
#  customer_id  :integer          not null
#  physician_id :integer
#  visit_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require "rails_helper"

describe Regimen do
  let(:ben_raspail) { customers(:ben_raspail) }

  describe "validations" do
    it "is valid with valid attributes" do
      regimen = FactoryBot.create(:regimen, customer: ben_raspail)

      expect(regimen).to be_valid
      expect(regimen.save).to be_truthy
    end
  end
end
