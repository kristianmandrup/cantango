require 'rspec'
require 'cantango'
require 'fixtures/models/items'

describe CanTango::PermissionEngine::Permission do
  before(:all) do
    @permission = CanTango::PermissionEngine::Permission.new :bloggers
  end

  subject do
    reads = ['Article' , 'Comment']
    writes = ['Article' , 'Post']
    @permission.static_rules.can = {:read => reads}
    @permission.static_rules.cannot = {:write => writes}
    @permission
  end

  its(:name) { should == :bloggers }

  context 'static rules' do
    subject { @permission.static_rules} 
    it { should include('can') }
    its(:can) { should include('read')}
    its(:cannot) { should include('write')}
  end

  context 'compiled rules' do
    subject { @permission.compiled_rules} 
    it { should include('can')}
    it { should include('cannot')}
    its(:can) { should == %|can(:read, Article)\ncan(:read, Comment)|}
    its(:cannot) { should == %|cannot(:write, Article)\ncannot(:write, Post)|}
  end

end
