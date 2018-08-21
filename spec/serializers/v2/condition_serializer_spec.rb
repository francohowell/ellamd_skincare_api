require "rails_helper"

describe V2::ConditionSerializer do
  let(:acne) { conditions(:acne) }

  describe "#as_json" do
    it ":basic mode: returns Condition hash" do
      result = V2::ConditionSerializer.new(acne, mode: :basic).as_json
      expect(result["id"]).to be_present
    end

    it ":complete mode: returns Condition hash" do
      result = V2::ConditionSerializer.new(acne, mode: :complete).as_json
      expect(result["id"]).to be_present
    end
  end
end
