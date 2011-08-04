module CanTango
  module Rules
    autoload_modules :Adaptor, :UserRelation, :Dsl, :Scope, :RuleClass

    include Dsl
    include CanTango::Rules::RuleClass
    # Examples:
    #   can :read, Project
    #   can [:read, :create], [Project, Post]
    #   can :read, Project, :active => true, :user_id => user.id
    def can(action, subject, conditions = nil, &block)
      rules << rule_class.new(true, action, subject, conditions, block)
    end

    # Examples:
    #   cannot :read, Project
    #   cannot [:read, :create], [Project, Post]
    #   cannot :read, Project, :active => true, :user_id => user.id    
    def cannot(action, subject, conditions = nil, &block)
      rules << rule_class.new(false, action, subject, conditions, block)
    end 
  end
end
