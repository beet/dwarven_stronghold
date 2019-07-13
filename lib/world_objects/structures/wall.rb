module WorldObjects
  module Structures
    class Wall < WorldObjects::Structures::Base
      def sprite
        @sprite ||= "0x259#{1 + rand(2)}".hex.chr("UTF-8") * 2
      end

      def description
        "wall"
      end

      def is_wall?
        true
      end
    end
  end
end
