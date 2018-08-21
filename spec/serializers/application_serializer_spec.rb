require "rails_helper"

describe ApplicationSerializer do
  describe ".date" do
    it "renders date formatted as year-month-day (1999-12-31)" do
      result = serialize(medical_profiles(:ben_raspail_medical_profile))
      expect(result["date-of-birth"]).to eq("1998-05-01")
    end
  end
end
