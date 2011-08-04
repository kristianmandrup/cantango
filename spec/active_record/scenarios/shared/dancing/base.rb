module Dancing
  module Base
    def scope_user scope
      send(:"current_#{scope}")
    end

    def scope_user_account scope
      send(:"current_#{scope}_account")
    end
  end

  class AbilityScope
    attr_accessor :ability

    def initialize ability
      @ability = ability
    end

    def can? *args
      ability.can? *args
    end

    def cannot? *args
      ability.cannot? *args
    end
  end
end
