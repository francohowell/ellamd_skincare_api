class AddSubscriptionsIdSequence < ActiveRecord::Migration[5.0]
  SEQUENCE_NAME = "subscriptions_id_seq".freeze

  def up
    result = execute("SELECT 1 FROM pg_class where relname = '#{SEQUENCE_NAME}'")
    return unless result.count.zero?

    execute <<~SQL
      CREATE SEQUENCE '#{SEQUENCE_NAME}';
      ALTER TABLE subscriptions ALTER id SET DEFAULT NEXTVAL('#{SEQUENCE_NAME}');
    SQL
  end

  def down; end
end
