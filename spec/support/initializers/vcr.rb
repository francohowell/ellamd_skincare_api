module VCR
  delegate :last_interaction, to: :current_cassette

  class Cassette
    delegate :last_interaction, to: :http_interactions

    class HTTPInteractionList
      def last_interaction
        @used_interactions.last || raise("No HTTP interactions have been recorded by VCR yet")
      end
    end
  end
end
