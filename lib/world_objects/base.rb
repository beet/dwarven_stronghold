require_relative "../locatable"

module WorldObjects
  class Base
    include Locatable

    def sprite
      "  "
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
