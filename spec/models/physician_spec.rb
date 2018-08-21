# == Schema Information
#
# Table name: physicians
#
#  id                           :integer          not null, primary key
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  signature_image_file_name    :string
#  signature_image_content_type :string
#  signature_image_file_size    :integer
#  signature_image_updated_at   :datetime
#  state_license                :string
#  dea_license                  :string
#  address                      :text
#  phone                        :string
#

require "rails_helper"

describe Physician do
  describe "#address" do
    it "returns empty string if address is missing" do
      physician = Physician.new
      expect(physician.address).to eq("")

      physician.address = "abc"
      expect(physician.address).to eq("abc")
    end
  end
end
