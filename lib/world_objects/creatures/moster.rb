module WorldObjects
  module Creatures
    class Monster < WorldObjects::Creatures::Base
      def sprite
        "XX"
      end

      private

      def species
        "monster"
      end
    end
  end
end
