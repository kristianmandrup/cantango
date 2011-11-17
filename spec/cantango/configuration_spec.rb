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
  subject { CanTango.config }

  describe 'clear!' do
    before do
      subject.roles.exclude :user
      subject.role_groups.exclude :admins

      subject.clear!
    end

    specify { subject.roles.excluded.should be_empty }
    specify { subject.role_groups.excluded.should be_empty }
  end

  describe 'ability' do
    specify { subject.ability.should be_a CanTango::Configuration::Ability }
  end

  describe 'hooks' do
    specify { subject.hooks.should be_empty }
  end

  describe 'hook' do
    specify { subject.hook(:name).should be_nil }
  end

  describe 'register_hook' do
    before do
      subject.register_hook :name, Proc.new { 2 }
    end
    specify { subject.hook(:name).should be_a Proc }
  end  

  describe 'include_models :default_guest_user' do
    before do
      subject.include_models :default_guest_user
    end
    specify { defined?(::Guest).should be_true }
  end

  describe "engines DSL" do
    before(:all) {
      CanTango.configure do |config|
        CanTango.config.engines.each do |engine|
          engine.set :off
        end
     end
    }

    describe 'engine(name)' do
      CanTango.config.engines.registered_names.each do |name|
        specify { subject.engine(name).off?.should be_true}
      end
    end

    describe 'each' do
      CanTango.config.engines.each do |engine|
        specify { engine.on?.should be_false}
        specify { engine.off?.should be_true}
      end
    end
  end
end
