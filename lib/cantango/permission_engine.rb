module CanTango
  module PermissionEngine
    autoload_modules :Collector, :Compiler, :Evaluator, :Selector
    autoload_modules :Factory, :Loader, :Parser, :Permission
    autoload_modules :RulesParser, :Store, :YamlStore, :Statements, :Statement
  end
end
