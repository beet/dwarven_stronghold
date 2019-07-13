module WorldObjects
  module Items
    class Item < WorldObjects::Items::Base
      def sprite
        "**"
      end

      def description
        "nondescript item"
      end
    end
  end
end
