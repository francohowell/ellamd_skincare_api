require "rails_helper"

describe V2::AnnotationSerializer do
  let(:annotation) { annotations(:ben_raspail_previous_visit_photo_annotation) }

  describe "#as_json" do
    it ":basic mode: returns Annotation hash" do
      result = V2::AnnotationSerializer.new(annotation, mode: :basic).as_json
      expect(result["id"]).to be_present
    end

    it ":complete mode: returns Annotation hash" do
      result = V2::AnnotationSerializer.new(annotation, mode: :complete).as_json
      expect(result["id"]).to be_present
    end
  end
end
