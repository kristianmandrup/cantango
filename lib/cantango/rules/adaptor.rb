module CanTango
  module Rules
    module Adaptor
      autoload_modules :Generic, :Relational, :Mongo
      autoload_modules :ActiveRecord, :DataMapper, :Mongoid, :MongoMapper

      # include adaptor depending on which ORM the object inherits from or includes
      def use_adaptor! base, object
        orm_map.each_pair do |orm, const|
          begin
            base.class.send :include, get_adapter(object, const.constantize, orm)
          rescue
            next
          end
        end
      end

      def get_adapter object, adaptor_class, orm
        object.kind_of?(adaptor_class) ? adaptor_for(orm) : adaptor_for(:generic)
      end

      def adaptor_for orm
        "CanTango::Rules::Adaptor::#{orm.to_s.camelize}".constantize
      end

      def orm_map
        {
          :active_record => "ActiveRecord::Base",
          :data_mapper => "DataMapper::Resource",
          :mongoid => "Mongoid::Document",
          :mongo_mapper => "MongoMapper::Document"
        }
      end
    end
  end
end

