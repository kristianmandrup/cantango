module CanTango
  module Api
    autoload_modules :User, :UserAccount, :Options, :Common, :Attributes

    def self.apis
      [:Can, :Scope, :Ability, :Session]
    end

    apis.each do |api|
      self.extend "CanTango::Api::User::#{api}".constantize
      self.extend "CanTango::Api::UserAccount::#{api}".constantize
    end
  end
end
