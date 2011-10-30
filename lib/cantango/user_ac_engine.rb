module CanTango
  class UserAcEngine < Engine
    autoload_modules :Executor

    def initialize ability
      super
    end

    def execute!
      return if !valid?
      debug "User AC Engine executing..."

      user_ac_rules = executor.execute!

      rules << user_ac_rules if !user_ac_rules.blank?
    end

    def executor
      CanTango::UserAcEngine::Executor.new ability, permissions
    end

    def valid?
      return false if !valid_mode?
      permissions.empty? ? invalid : true
    end

    def engine_name
      :user_ac
    end

    protected

    def permissions
      candidate.respond_to?(:all_permissions) ? candidate.all_permissions : []
    end

    def invalid
      debug "No permissions for #{candidate} found for #all_permissions call"
      false
    end
  end
end
