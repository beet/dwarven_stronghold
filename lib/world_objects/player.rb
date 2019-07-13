require_relative "creatures/human"

module WorldObjects
  class Player < WorldObjects::Creatures::Human
    def is_player?
      true
    end
  end
end
