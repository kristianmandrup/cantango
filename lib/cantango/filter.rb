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
            case name.to_sym
            when :REST, :MANAGE
              tango_filter :create => :OPTS, :create! => :OPTS, :update_attributes => :OPTS, :update_attributes! => :OPTS
              tango_filter :destroy, :destroy!
            when :CREATE, :NEW
              tango_filter :create => :OPTS, :create! => :OPTS
            when :UPDATE, :EDIT
              tango_filter :update_attributes => :OPTS, :update_attributes! => :OPTS
            when :DELETE, :DESTROY
              tango_filter :destroy, :destroy!
            else
              meth_name = name.to_s
              postfix = (meth_name =~ /\!$/) ? '!' : ''
              postfix = (meth_name =~ /\?$/) ? '?' : postfix
              postfix = "_by#{postfix}"
              clean_meth_name = meth_name.to_s.sub(/[\!|\?]$/, '') + postfix
              puts "clean sym: #{clean_meth_name}"
              define_method :"#{clean_meth_name}" do |user|
                send(name) if user_ability(user).can? meth_name.to_sym, self
              end
            end
          when Hash
            base = self
            name.each_pair do |meth_name, argies|
              argies = argies.kind_of?(Symbol) ? [argies] : argies
              argies = argies.map(&:to_s).map{|a| a == 'ARGS' ? '*args' : a}
              args = argies.map{|a| a == 'OPTS' ? 'options = {}' : a}.join(',')
              args_call = argies.map{|a| a == 'OPTS' ? 'options' : a}.join(',')
              postfix = (meth_name =~ /\!$/) ? '!' : ''
              postfix = (meth_name =~ /\?$/) ? '?' : postfix
              postfix = "_by#{postfix}"
              clean_meth_name = meth_name.to_s.sub(/[\!|\?]$/, '') + postfix
              puts "clean hash: #{clean_meth_name}"

              base.class_eval %{
                def #{clean_meth_name} the_user, #{args}
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
