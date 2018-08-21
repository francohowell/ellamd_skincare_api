require "rails_helper"

describe V2::PhysicianSerializer do
  let(:hannibal_lecter) { physicians(:hannibal_lecter) }

  describe "#as_json" do
    it ":basic mode: returns Physician hash" do
      result = V2::PhysicianSerializer.new(hannibal_lecter, mode: :basic).as_json
      expect(result["id"]).to be_present
    end

    it ":complete mode: returns Physician hash" do
      result = V2::PhysicianSerializer.new(hannibal_lecter, mode: :complete).as_json
      expect(result["id"]).to be_present
    end
  end
end
