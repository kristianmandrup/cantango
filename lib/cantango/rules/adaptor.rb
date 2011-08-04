module CanTango
  module Rules
    module Adaptor
      autoload_modules :Generic
      autoload_modules :ActiveRecord, :Mongoid

      # include adaptor depending on which ORM the object inherits from or includes
      def use_adaptor! base, object
        orm_map.each_pair do |orm, const|
          begin
            adaptor_class = const.constantize
            base.class.send(:include, adaptor(orm)) if object.kind_of?(adaptor_class)
          rescue 
            next
          end
        end
      end

      def adaptor orm
        "CanTango::Rules::Adaptor::#{orm.to_s.camelize}".constantize
      end

      def orm_map
        {
          :active_record => "ActiveRecord::Base",
          :mongoid => "Mongoid::Document"
        }
      end
    end
  end
end

