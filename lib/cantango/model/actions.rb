module CanTango::Model
  module Actions
    def self.included(base)
      register base
      base.extend ClassMethods
    end

    def self.register clazz
      model_actions[clazz.to_s.underscore.to_sym] = CanTango::Configuration::Models::Actions.new
    end

    def self.register_member_actions clazz, *actions
      actions.flatten.each do |action|
        model_actions[clazz].add_member action.to_sym
      end
    end

    def self.register_collection_actions clazz, *actions
      actions.flatten.each do |action|
        model_actions[clazz].add_collection action.to_sym
      end
    end

    def self.model_actions
      CanTango.config.models.actions
    end

    module ClassMethods
      def tango_actions *actions
        action_clazz = self.name.underscore.to_sym
        options = actions.extract_options!
        clazz = CanTango::Model::Actions
        case options[:as]
        when :member
          clazz.register_member_actions action_clazz, *actions
        when :collection
          clazz.register_collection_actions action_clazz, *actions
        else
          raise ArgumentError, "You must specify a :to option as the last argument, of either :member or :collection"
        end
      end
    end
  end
end

