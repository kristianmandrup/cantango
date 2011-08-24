module CanTango
  class Ability
    class Cache
      class Key
        attr_reader :session

        def initialize user, session
          @user = user
          @session = session
        end

        def value
          raise "#{user.class} must have a method ##{user_key_field}. You can configure this with CanTango.config#user.unique_key_field" if !user.respond_to?(user_key_field)
          @value ||= [user_key, subject_roles_hash].hash
        end

        def same?
          raise "No session available" if !session
          session[:cache_key] && (value == session[:cache_key])
        end

        protected

        def user_key
          user.send(user_key_field)
        end

        def user_key_field
          CanTango.config.user.unique_key_field || :email
        end

        def subject_roles_hash
          [subject.roles_list, subject.role_groups_list].hash
        end
      end
    end
  end
end

