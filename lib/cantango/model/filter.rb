module CanTango::Model
  module Filter
    def self.included(base)
      base.send :include, CanTango::Api::User::Ability
      base.extend ClassMethods
    end

    def self.clean_meth_name meth_name
      postfix = (meth_name =~ /\!$/) ? '!' : ''
      postfix = (meth_name =~ /\?$/) ? '?' : postfix
      postfix = "_by#{postfix}"
      meth_name.to_s.sub(/[\!|\?]$/, '') + postfix
    end

    def self.normalize_args args
      args = args.kind_of?(Symbol) ? [args] : args
      args.map(&:to_s).map{|a| a == 'ARGS' ? '*args' : a}
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
              method_name = CanTango::Model::Filter.clean_meth_name meth_name
              define_method :"#{method_name}" do |user|
                send(name) if user_ability(user).can? meth_name.to_sym, self
              end
            end
          when Hash
            base = self
            name.each_pair do |meth_name, args|
              norm_args = CanTango::Model::Filter.normalize_args args
              args = norm_args.map{|a| a == 'OPTS' ? 'options = {}' : a}.join(',')
              args_call = norm_args.map{|a| a == 'OPTS' ? 'options' : a}.join(',')

              method_name = CanTango::Model::Filter.clean_meth_name meth_name

              base.class_eval %{
                def #{method_name} the_user, #{args}
                  send(:#{meth_name}, #{args_call}) if user_ability(the_user).can? :#{meth_name}, self
                end
              }
            end
          end
        end
      end # def

      def tango_account_filter *method_names
        method_names.flatten.each do |name|
          case name
          when String, Symbol
            case name.to_sym
            when :REST, :MANAGE
              tango_account_filter :create => :OPTS, :create! => :OPTS, :update_attributes => :OPTS, :update_attributes! => :OPTS
              tango_account_filter :destroy, :destroy!
            when :CREATE, :NEW
              tango_account_filter :create => :OPTS, :create! => :OPTS
            when :UPDATE, :EDIT
              tango_account_filter :update_attributes => :OPTS, :update_attributes! => :OPTS
            when :DELETE, :DESTROY
              tango_account_filter :destroy, :destroy!
            else
              meth_name = name.to_s
              method_name = CanTango::Model::Filter.clean_meth_name meth_name
              define_method :"#{method_name}" do |user|
                send(name) if account_ability(user).can? meth_name.to_sym, self
              end
            end
          when Hash
            base = self
            name.each_pair do |meth_name, args|
              norm_args = CanTango::Model::Filter.normalize_args args
              args = norm_args.map{|a| a == 'OPTS' ? 'options = {}' : a}.join(',')
              args_call = norm_args.map{|a| a == 'OPTS' ? 'options' : a}.join(',')

              method_name = CanTango::Model::Filter.clean_meth_name meth_name

              base.class_eval %{
                def #{method_name} the_user, #{args}
                  send(:#{meth_name}, #{args_call}) if account_ability(the_user).can? :#{meth_name}, self
                end
              }
            end
          end
        end
      end
    end
  end
end
