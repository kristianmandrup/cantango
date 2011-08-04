module CanTango::PermissionEngine
  class Statement
    attr_reader :method, :action, :conditions

    def initialize method, action, conditions = {}
      @method, @action, @conditions = [method, action, conditions]
    end

    def to_code
      line = conditions.empty? ? "#{method}(:#{action})" : "#{method}(:#{action}, #{conditions})"
    end
  end
end

