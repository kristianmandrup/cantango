module CanTango
  class UserAcEngine < Engine
    include CanTango::Ability::Executor
    include CanTango::Ability::RoleHelpers
    include CanTango::Ability::UserHelpers

    def initialize ability
      super
    end

    def permit_rules
      permissions.each do |permission|
        ability.can permission.action.to_sym, permission.thing_type.constantize do |thing|
          thing.nil? || permission.thing_id.nil? || permission.thing_id == thing.id
        end
      end
      rules += ability_rules if !ability_rules.blank?
    end

    def valid?
      return false if !valid_mode?
      permissions.empty? ? invalid : true
    end

    def engine_name
      :user_ac
    end

    protected

    def ability_rules
      ability.send(:rules)
    end

    alias_method :cache_key, :engine_name

    def key_method_names
      [:permissions_hash]
    end

    def start_execute
      debug "User AC Engine executing..."
    end

    def end_execute
      debug "Done User AC Engine"
    end

    def permissions
      candidate.respond_to?(:all_permissions) ? candidate.all_permissions : []
    end

    def invalid
      debug "No permissions for #{candidate} found for #all_permissions call"
      false
    end
  end
end
