module CanTango
  class PermitEngine < Engine
    autoload_modules :Builder, :Compatibility, :Executor
    autoload_modules :Factory, :Finder, :Loaders, :Util, :RoleMatcher

    def initialize ability
      super
    end

    def execute!
      return if !valid?
      debug "Permit Engine executing..."

      # CanTango.config.permits.clear_executed! # should there be an option clear before each execution?
      permits.each_pair do |type, permits|
        # TODO: somehow type specific caching of result of permits!
        permits.each do |permit|
          CanTango.config.permits.was_executed(permit, ability) if CanTango.config.debug.on?
          break if permit.execute == :break
        end
      end
    end

    def engine_name
      :permit
    end

    def valid?
      return false if !valid_mode?
      permits.empty? ? invalid : true
    end

    # by default, only execute permits for which the user
    # has a role or a role group
    # also execute any permit marked as special
    def permits
      @permits ||= permit_factory.build!
    end

    def permit_class_names
      @permit_class_names ||= permits.map{|p| p.class.to_s}
    end

    protected

    def invalid
      debug "No permits found!"
      false
    end

    def permit_factory
      @permit_factory ||= CanTango::PermitEngine::Factory.new ability
    end
  end
end
