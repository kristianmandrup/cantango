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
            base = self
            name.each_pair do |meth_name, argies|
              argies = argies.kind_of?(Symbol) ? [argies] : argies
              argies = argies.map(&:to_s).map{|a| a == 'ARGS' ? '*args' : a}
              args = argies.map{|a| a == 'OPTS' ? 'options = {}' : a}.join(',')
              args_call = argies.map{|a| a == 'OPTS' ? 'options' : a}.join(',')
              base.class_eval %{
                def #{meth_name}_by the_user, #{args}
                  send(:#{meth_name}, #{args_call}) if user_ability(the_user).can? :#{meth_name}, self
                end
              }
            end
          end
        end
      end
    end
  end
end
