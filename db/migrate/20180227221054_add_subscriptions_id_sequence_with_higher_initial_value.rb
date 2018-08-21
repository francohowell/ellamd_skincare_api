class AddSubscriptionsIdSequenceWithHigherInitialValue < ActiveRecord::Migration[5.0]
  SEQUENCE_NAME = "subscriptions_id_seq".freeze

  def up
    execute <<~SQL
      ALTER TABLE subscriptions ALTER id SET DEFAULT 0;
      DROP SEQUENCE IF EXISTS #{SEQUENCE_NAME};
      CREATE SEQUENCE #{SEQUENCE_NAME} START WITH 1000 OWNED BY subscriptions.id;
      ALTER TABLE subscriptions ALTER id SET DEFAULT NEXTVAL('#{SEQUENCE_NAME}');
    SQL
  end

  def down; end
end
