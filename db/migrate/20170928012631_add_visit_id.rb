class AddVisitId < ActiveRecord::Migration[5.0]
  def change
    add_reference :photos, :visit, foreign_key: true
    add_reference :diagnoses, :visit, foreign_key: true
    add_reference :prescriptions, :visit, foreign_key: true
  end
end
