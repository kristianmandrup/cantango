module CanTango
  class Configuration
    class Autoload
      include Singleton

      [:models, :permits].each do |name|
        attr_accessor name 

        # def permits?
        #   @permits ||= :on
        #   @permits == :on
        # end
        class_eval %{
          def #{name}?
            @#{name} ||= :on
            @#{name} == :on
          end
        }
      end
    end
  end
end


