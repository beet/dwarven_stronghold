module WorldObjects
  module Items
    class Item < WorldObjects::Items::Base
      EMOJIS = %w(🔑 💍 💎 🧽)

      def sprite
        @sprite ||= EMOJIS.sample
      end

      def description
        @description ||= Faker::Games::Minecraft.item
      end
    end
  end
end
