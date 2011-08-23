require 'rspec'
require 'cantango'
require 'sourcify'

CanTango.adapters :compiler, :moneta

describe CanTango::Ability::Cache::Kompiler do

module Cachestub
  
  class << self
  include CanTango::Ability::Cache::Kompiler

  def compile_rules rules
    compile_rules! rules
  end

  def decompile_rules rules
    decompile_rules! rules
  end

  end
end
  
  before(:each) { 
    $b = [:a,:b,:c]
    @condition_block = Proc.new { |arg| $b = [1, 2, 3, arg] } 
    @rules = [CanCan::Rule.new(true, :read, :all, nil, @condition_block) ]
  }

  it "should compile! rules" do
    Cachestub.compile_rules(@rules).first.block.should == "proc { |arg| $b = [1, 2, 3, arg] }"
  end

  # Direct testing doesn't work here because raw_rules.first.eval.to_source raises exception.
  # Sourcify::CannotParseEvalCodeError: Sourcify::CannotParseEvalCodeError
  #
  # I.e. things like eval( (Proc.new{}).to_source ).to_source do not work. 
  # But for our needs basic two operations flow like Proc -> String -> (evaled)Proc is pretty enough
  it "should decompile! rules" do
    compiled_rules = Cachestub.compile_rules(@rules)
    raw_rules = Cachestub.decompile_rules compiled_rules
    raw_rules.first.block.call(4)
    $b.should == [1,2,3,4]
  end

end
