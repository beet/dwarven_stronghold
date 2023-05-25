module WorldObjects
  module Creatures
    class Monster < WorldObjects::Creatures::Base
      EMOJIS = %w(😈 👿 👹 👺 👾 👽)

      def sprite
        @sprite ||= EMOJIS.sample
      end

      private

      def species
        @species ||= Faker::Games::DnD.monster
      end
    end
  end
end
