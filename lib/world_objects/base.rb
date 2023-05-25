require_relative "../locatable"

=begin

WorldObjects are composed with the Locatable module that provdides them with
location functionality.

They also have a "sprite", which is a text string used to render them in the
map".

You can call any predicate method on any world object that is prefixed with
"is_", like "is_wall?" without having to define it, and it will return false.

=end
module WorldObjects
  class Base
    include Locatable

    attr_reader :name

    def initialize(name: nil)
      @name = name
    end

    def sprite
      "  "
    end

    def description
      name || "object"
    end

    # Rather than explicitly defining abstract methods for predicates like
    # is_wall?, all world objects will return false from any is_foo? method,
    # allowing only the specific world object to override their own methods to
    # return true as needed.
    def method_missing(method, *args, &block)
      return super(method, *args, &block) unless method.to_s =~ /^is_.+\?$/

      self.class.class_eval do
        define_method(method) do |*args, &block|
          false
        end
      end

      self.send(method, *args, &block)
    end
  end
end
