require_relative "base"

module WorldObjects
  module Creatures
    class Human < WorldObjects::Creatures::Base
      def sprite
        "👤" # 🤺
      end

      private

      def species
        "human"
      end
    end
  end
end
