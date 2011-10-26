module CanTango
  class Engine
    include CanTango::Helpers::Debug

    attr_reader :ability

    def initialize ability
      @ability = ability
    end

    def execute!
      # raise NotImplementedError
    end

    def engine_name
      raise NotImplementedError
    end

    protected

    def valid_mode?
      valid_cache_mode? || valid_no_cache_mode?
    end

    def valid_cache_mode?
      modes.include?(:cache) && cache_mode?
    end

    def valid_no_cache_mode?
      modes.include?(:no_cache) && !cache_mode?
    end

    def modes
      CanTango.config.engine(engine_name.to_sym).modes
    end

    def cache_mode?
      ability.cached?
    end

    def user
      ability.user
    end

    def subject
      ability.subject
    end

    def candidate
      ability.candidate
    end
  end
end
