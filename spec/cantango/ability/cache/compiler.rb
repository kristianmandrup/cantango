require 'rspec'
require 'cantango'
require 'sourcify'

describe CanTango::Ability::Cache::Kompiler do

module CacheStub
  
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
    @condition_block = Proc.new { Time.now > 5 } 
    @rules = [CanCan::Rule.new(true, :read, :all, nil, @condition_block) ]
  }

  it "should compile! rules" do
    CacheStub.compile_rules(@rules).first.block.should == "proc { (Time.now > 5) }"
  end

  it "should decompile! rules" do
    compiled_rules = CacheStub.compile_rules(@rules)
    raw_rules = CacheStub.decompile_rules compiled_rules
    puts raw_rules.first.block.to_source
    #raw_rules.first.block.to_source.should == @condition_block.to_source
  end

end
