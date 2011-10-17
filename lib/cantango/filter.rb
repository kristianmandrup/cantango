module CanTango
  module Filter
    def self.included(base)
      base.send :include, CanTango::Api::User::Ability
      base.extend ClassMethods
    end

    module ClassMethods
      def tango_filter *method_names
        method_names.flatten.each do |name|
          case name
          when String, Symbol
            define_method :"#{name}_by" do |user|
              send(name) if user_ability(user).can? name.to_sym, self
            end
          when Hash
            meth_name = name.keys.first
            argies = name.values.first
            args = argies.map(&:to_s).join(',')
            class_eval %{
              def #{meth_name}_by the_user, #{args}
                send(:#{meth_name}, #{args}) if user_ability(the_user).can? :#{meth_name}, self
              end
            }
          end
        end
      end
    end
  end
end
