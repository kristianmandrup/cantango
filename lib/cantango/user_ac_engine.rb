module CanTango
  class UserAcEngine < Engine
    autoload_modules :Executor

    def initialize ability
      super
    end

    def execute!
      if CanTango.config.debug.on?
        puts "User AC Engine executing..."
      end

      candidate.permissions.each do |permission|
        ability.can permission.action.to_sym, permission.thing_type.constantize do |thing|
          thing.nil? || permission.thing_id.nil? || permission.thing_id == thing.id
        end
      end
    end
  end
end
