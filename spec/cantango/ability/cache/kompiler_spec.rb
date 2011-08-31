require 'rspec'
require 'cantango'
require 'sourcify'

CanTango.config.adapters.use :compiler, :moneta

describe CanTango::Ability::Cache::Kompiler do
  subject do
    CanTango::Ability::Cache::Kompiler.new
  end

  before(:each) do
    $b = [:a,:b,:c]
    @condition_block = Proc.new { |arg| $b = [1, 2, 3, arg] } 
    @rules = [CanCan::Rule.new(true, :read, :all, nil, @condition_block) ]
  end

  it "should compile! rules" do
    subject.compile!(@rules).first.block.should == "proc { |arg| $b = [1, 2, 3, arg] }"
  end

  # Direct testing doesn't work here because raw_rules.first.eval.to_source raises exception.
  # Sourcify::CannotParseEvalCodeError: Sourcify::CannotParseEvalCodeError
  #
  # I.e. things like eval( (Proc.new{}).to_source ).to_source do not work. 
  # But for our needs basic two operations flow like Proc -> String -> (evaled)Proc is pretty enough
  it "should decompile! rules" do
    compiled_rules = subject.compile!(@rules)
    raw_rules = subject.decompile! compiled_rules
    raw_rules.first.block.call(4)
    $b.should == [1,2,3,4]
  end
end
