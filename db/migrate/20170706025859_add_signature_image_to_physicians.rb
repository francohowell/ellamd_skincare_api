class AddSignatureImageToPhysicians < ActiveRecord::Migration[5.0]
  def change
    add_attachment :physicians, :signature_image
  end
end
