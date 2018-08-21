class SwitchToUserOnIdentity < ActiveRecord::Migration[5.0]
  def change
    (Customer.all + Physician.all + Pharmacist.all + Administrator.all).each do |user|
      Identity.find(user.identity_id).update!(user: user)
    end
  end
end
