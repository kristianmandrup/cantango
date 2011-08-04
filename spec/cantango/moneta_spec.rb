require 'spec_helper'

require "moneta/adapters/memory"

shared_examples_for "a read/write Moneta cache" do
  types = {
    "String" => ["key", "key2"],
    "Object" => [{:foo => :bar}, {:bar => :baz}]
  }

  types.each do |type, (key, key2)|
    it "reads from keys that are #{type}s like a Hash" do
      @cache[key].should == nil
    end
  end
end

describe "Moneta::Adapters::Memory" do
  #class EmptyMiddleware
    #include Moneta::Middleware
  #end

  before(:each) do
    @cache = Moneta::Builder.build do
      run Moneta::Adapters::Memory
    end
    @cache.clear
  end

  it_should_behave_like "a read/write Moneta cache"
end
