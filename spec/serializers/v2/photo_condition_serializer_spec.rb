require "rails_helper"

describe V2::PhotoConditionSerializer do
  let(:photo_condition) { photo_conditions(:ben_raspail_previous_visit_photo_condition) }

  describe "#as_json" do
    it ":complete mode: returns PhotoCondition hash with Condition" do
      result = V2::PhotoConditionSerializer.new(photo_condition, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["condition"]).to be_present
    end
  end
end
