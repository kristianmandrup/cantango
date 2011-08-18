require 'rails/generators/base'
require 'sugar-high/array'
require 'active_support/inflector'
require 'rails_artifactor'
# require 'logging_assist'
#
require 'generators/cantango/base'
require 'generators/cantango/license_base'
require 'generators/cantango/permit_generator'

module Cantango
  module Generators
    class AccountPermitGenerator < Cantango::Generators::Base
      desc "Creates a Permit for an account in 'app/permits' with specific permissions and/or licenses"

      argument     :account,        :type => :string,   :default => '',     :desc => "Account class to create permit for"

      class_option :licenses,       :type => :array,    :default => [],     :desc => "Licenses to use in Permit"

      class_option :account,        :type => :string,
          :desc => "Generate permits for a specific user account"

      class_option :group,          :type => :boolean,  :default => false,  :desc => "Generate permit for a role group"

      source_root File.dirname(__FILE__) + '/templates'

      def main_flow
        return if account.empty?
        template_permit account
      end

      protected

      def account?
        true
      end

      include CanTango::Generators::Base
      include CanTango::Generators::LicenceBase
    end
  end
end


