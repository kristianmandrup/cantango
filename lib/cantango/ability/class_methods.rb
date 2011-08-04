module CanTango
  class Ability
    mattr_accessor :orm, :strategy
    
    module ClassMethods
      # BAD!
      def orm= orm
        @orm = orm 
        set_strategy orm        
      end

      def set_strategy orm
        @strategy = relational_orm?(orm) ? :default : :string
      end
  
      private
  
      def relational_orm? orm
        relations_orms.include?(orm)
      end
  
      def relations_orms
        [:active_record, :generic]
      end
    end    
  end
end