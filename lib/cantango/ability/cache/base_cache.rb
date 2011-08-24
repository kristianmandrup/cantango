module CanTango
  class Ability
    class Cache
      class BaseCache
        attr_reader :name, :options

        def initialize name, options = {}
          @name, @options = [name, options]

          options.each_pair do |name, value|
            var = :"@#{name}"
            self.instance_variable_set(var, value)
          end
        end

        def load key
          raise NotImplementedError
        end

        def save key, rules
          raise NotImplementedError
        end
      end
    end
  end
end
