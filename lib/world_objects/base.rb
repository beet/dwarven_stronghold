require_relative "../locatable"

module WorldObjects
  class Base
    include Locatable

    def sprite
      "  "
    end

    def is_visible?
      true
    end

    # Some meta-programming using MethodMissing to catch all other predicate
    # methods like #is_foo? would allow child classes to create whatever they
    # want, like is_visible? can_open? etc without having to know/define them
    # all in advance as asbtract methods.
    def is_wall?
      false
    end
  end
end
