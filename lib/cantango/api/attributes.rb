module CanTango
  module Api
    module Attributes
      [:read, :edit].each do |action|
        define_method :"#{action}_attribute" do |name|
          :"#{action}_attr_\#{name}"
        end

        define_method :"#{action}_attributes" do |*names|
          names.select_symbols.map { |name| send("#{action}_attribute", name) }
        end
      end
    end
  end
end


