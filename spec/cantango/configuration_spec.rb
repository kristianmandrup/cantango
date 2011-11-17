require 'rspec'
require 'cantango'
require 'fixtures/models'

@user = User.new('kris', 'kris@gmail.com')

class CanTango::CustomAbility < CanTango::Ability
  def initialize candidate, options = {}
    'custom'
  end
end

describe CanTango::Configuration do
  describe 'clear!' do
    subject { CanTango.config }

    before do
      subject.roles.exclude :user
      subject.role_groups.exclude :admins

      subject.clear!
    end

    specify { subject.roles.excluded.should be_empty }
    specify { subject.role_groups.excluded.should be_empty }
  end

  describe 'hooks' do
    specify { subject.hooks.should be_empty }
  end

  describe 'hook' do
    specify { subject.hook[:name].should be_nil }
  end

  describe 'register_hook' do
    before do
      subject.register_hook :name, Proc.new { 2 }
    end
    specify { subject.hook[:name].should == 2 }
  end  

  describe "engines DSL" do
    before(:all) {
      CanTango.configure do |config|
        CanTango.config.engines.each do |engine|
          engine.set :off
        end
     end
    }

    CanTango.config.engines.each do |engine|
      specify { engine.on?.should be_false}
      specify { engine.off?.should be_true}
    end
  end
end
