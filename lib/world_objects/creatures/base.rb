=begin

Creature objects could have skills, abilities, and attributes used to create a
combat system.

=end
module WorldObjects
  module Creatures
    class Base < WorldObjects::Base
      def description
        species
      end

      private

      def species
        ""
      end
    end
  end
end
