class AddExtraSkinProfileQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :sunscreen_frequency, :string
    add_column :customers, :sunscreen_brand, :string
    add_column :customers, :using_peels, :text
    add_column :customers, :using_retinol, :text
    add_column :customers, :user_skin_extra_details, :text
  end
end
