module CanTango
  class Ability
    class Cache
      class Key
        attr_reader :user, :subject

        def initialize user, subject = nil, method_names = nil
          @user = user
          @subject = subject || user
          @method_names = method_names if method_names
        end

        def method_names
          @method_names ||= [:roles_list, :role_groups_list]
        end

        def self.create_for ability
          self.new ability.user, ability.subject
        end

        def value
          raise "No key could be generated for User:#{user.inspect} and Subject:#{subject} - key field: #{user_key_field}" if hash_values.empty?
          @value ||= hash_values.hash
        end

        def same? session
          raise "No session available" if !session
          session[:cache_key] && (value == session[:cache_key].value)
        end

        def to_s
          "key hash: #{value}"
        end

        protected

        def hash_values
          @hash_values ||= [user_key, subject_roles_hash, permissions_key].compact
        end

        def permissions_key
          return subject.send(:permissions_hash) if permissions_key? && subject.respond_to?(:permissions_hash)
          subject.send(:permissions) if permissions_key?
        end

        def permissions_key?
          subject.respond_to?(:permissions) && permission_engine.modes.include?(:cache) && permission_engine.on?
        end

        def user_key
          # raise "#{user.class} must have a method ##{user_key_field}. You can configure this with CanTango.config#user.unique_key_field" if !user.respond_to?(user_key_field)
          user.send(user_key_field) if user.respond_to? user_key_field
        end

        def user_key_field
          CanTango.config.user.unique_key_field || :email
        end

        def subject_roles_hash
          role_hash_values.empty? ? nil : role_hash_values.hash
        end

        def role_hash_values
          @role_hash_values ||= method_names.inject([]) do |result, meth_name|
            result << subject.send(meth_name) if use_in_hash? meth_name
            result
          end
        end

        private

        def permission_engine
          CanTango.config.engine(:user_ac)
        end

        def use_in_hash? meth_name
          subject.respond_to?(meth_name) && CanTango.config.permits.enabled_types.include?(meth_map[meth_name])
        end

        def meth_map
          {:roles_list => :role, :role_groups_list => :role_group }
        end
      end
    end
  end
end

