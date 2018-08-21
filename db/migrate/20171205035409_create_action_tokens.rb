class CreateActionTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :action_tokens do |t|
      t.string :token, index: true
      t.references :owner, polymorphic: true
      t.references :tokenable, polymorphic: true
      t.datetime :used_at

      t.timestamps
    end
  end
end
