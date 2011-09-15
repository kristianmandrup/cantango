module CanTango
  module Rules
    autoload_modules :Adaptor, :UserRelation, :Dsl, :Scope, :RuleClass

    include Dsl
    include CanCan::Ability
  end
end
