require_relative "base"

module WorldObjects
  module Creatures
    class Human < WorldObjects::Creatures::Base
      def sprite
        "PP"
      end

      private

      def species
        "human"
      end
    end
  end
end
