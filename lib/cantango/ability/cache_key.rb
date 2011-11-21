module CanTango
  class Ability
    class CacheKey
      attr_reader :user, :subject

      def initialize user, subject = nil
        @user = user
        @subject = subject || user
      end

      def self.create_for ability
        self.new ability.user, ability.subject
      end

      def value
        raise "No key could be generated for User:#{user.inspect} and Subject:#{subject} - key field: #{user_key_field}" if !user_key
        @value ||= user_key.hash
      end

      def to_s
        "key hash: #{value}"
      end

      protected

      def user_key
        # raise "#{user.class} must have a method ##{user_key_field}. You can configure this with CanTango.config#user.unique_key_field" if !user.respond_to?(user_key_field)
        user.send(user_key_field) if user.respond_to? user_key_field
      end

      def user_key_field
        CanTango.config.user.unique_key_field || :email
      end
    end
  end
end
