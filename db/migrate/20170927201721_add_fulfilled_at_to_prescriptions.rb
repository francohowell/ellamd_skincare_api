class AddFulfilledAtToPrescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :fulfilled_at, :datetime
  end
end
