require "rails_helper"

describe V2::PhotoSerializer do
  let(:photo) { photos(:ben_raspail_previous_visit_photo) }

  describe "#as_json" do
    it "basic mode: returns Photo" do
      result = V2::PhotoSerializer.new(photo, mode: :basic).as_json

      expect(result["id"]).to be_present
      expect(result["medium-url"]).to be_present
    end

    it "complete mode: returns Photo with Annotations and PhotoConditions" do
      result = V2::PhotoSerializer.new(photo, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["medium-url"]).to be_present
      expect(result["annotations"]).to be_present
      expect(result["photo-conditions"]).to be_present
    end
  end
end
