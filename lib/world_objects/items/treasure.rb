module WorldObjects
  module Items
    class Treasure < WorldObjects::Items::Base
      def sprite
        "  "
      end

      def description
        "treasure chest"
      end
    end
  end
end
