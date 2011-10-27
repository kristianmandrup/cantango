class MongoidModels
  def self.all
    @@models ||= []
  end
end

module Mongoid
  module Document
    def self.included(klass)
      MongoidModels.all << klass
    end
  end
end

class MongoMapperModels
  def self.all
    @@models ||= []
  end
end

module MongoMapper
  module Document
    def self.included(klass)
      MongoMapperModels.all << klass
      klass.extend Plugins
      klass.extend Translation
    end
  end
end


