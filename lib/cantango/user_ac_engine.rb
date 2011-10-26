module CanTango
  class UserAcEngine < Engine
    autoload_modules :Executor

    def initialize ability
      super
    end

    def execute!
      return if !valid?
      debug "User AC Engine executing..."

      permissions.each do |permission|
        ability.can permission.action.to_sym, permission.thing_type.constantize do |thing|
          thing.nil? || permission.thing_id.nil? || permission.thing_id == thing.id
        end
      end
    end

    def valid?
      permissions.empty? ? invalid : true
    end

    protected

    def permissions
      candidate.respond_to?(:permissions) ? candidate.permissions : []
    end

    def invalid
      debug "No permissions for #{candidate} found!"
      false
    end
  end
end
