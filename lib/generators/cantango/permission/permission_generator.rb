require 'generators/cantango/base'

module Cantango
  module Generators
    class PermissionGenerator < Cantango::Generators::Base
      desc "Creates a Permission for a model in 'app/models'"

      argument     :name,       :type => :string,
          :desc => "Model to create Permission model for"

      source_root File.dirname(__FILE__) + '/templates'

      def main_flow
        relational
      end

      def relational
        Rails::Generators.invoke "model", ['Permission', "#{name}_id:integer", "thing_id:integer", "thing_type:string", "action:string"]

        puts "Manual Modifications to Permission model:"
        puts "-----------------------------------------"
        puts "belongs_to :#{name}"
        puts "belongs_to :thing, :polymorphic => true"

        puts "Manual Modifications to #{name.to_s.camelize} model:"
        puts "has_many :permissions"
        puts "-----------------------------------------"

        puts "and then run:"
        puts "rake db:migrate"
      end

      def document_store
        Rails::Generators.invoke "model", ['Permission']
        # use rails_artifactor to edit model?!
      end

      protected

    end
  end
end

