=begin

Structures could be anything used to populate the map with objects that
creatures can't walk through, like walls, or openable things like doors (which
would require re-factoring #is_wall? out to something more like
#is_traversable?)

=end
module WorldObjects
  module Structures
    class Base < WorldObjects::Base
    end
  end
end
