module CanTango
  class PermitEngine < Engine
    autoload_modules :Builder, :Compatibility, :Executor
    autoload_modules :Factory, :Finder, :Loaders, :Util, :RoleMatcher

    include CanTango::Ability::Executor

    def initialize ability
      super
    end

    def permit_rules
      # push result of each permit type execution into main ability rules array
      permits.each_pair do |type, permits|
        permit_rules = executor(type, permits).execute!
        rules << permit_rules if !permit_rules.blank?
      end
    end

    def executor type, permits
      CanTango::Permits::Executor.new ability, type, permits
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

    def start_execute
      debug "Permit Engine executing..."
    end

    def invalid
      debug "No permits found!"
      false
    end

    def permit_factory
      @permit_factory ||= CanTango::PermitEngine::Factory.new ability
    end

    def cache_key
      :permits
    end

    def key_method_names
      permits.keys.map {|type| key type }.compact
    end

    def key type
      case type
      when :role
        roles_list_meth
      when :role_group
        role_groups_list_meth
      else
        nil
      end
    end
  end
end
