module CanTango
  class Ability
    module Helper
      module User
        def user
          return subject.user if subject.respond_to? :user
          subject
        end

        def user_key_field
          key_field = config.user.unique_key_field
          raise "\nModel <#{user.class}> has no ##{key_field} as defined in CanTango.config.user.unique_key_field" if !user.respond_to?(key_field)
          key_field
        end
      end
    end
  end
end
