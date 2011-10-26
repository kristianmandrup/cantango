require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

CanTango.configure do |config|
  config.clear!
end

class Thingy
  attr_reader :name, :id

  def initialize name
    @name = name
    @id = rand(1000)
  end
end


describe CanTango::UserAcEngine do
  context 'User model has_many Permissions' do
    before do
      @thingy = Thingy.new 'a'
      @user = User.new 'kris'
      @permission = Permission.new @user, :edit, @thingy
      @user.permissions << @permission
    end

    describe 'Permission' do
      subject { @permission }
        its(:thing_id) { should be_a(Integer) }
    end

    describe 'UserAc engine' do
      let (:ability) do
        CanTango::Ability.new @user
      end
      subject { CanTango::UserAcEngine.new ability }

      describe '#execute!' do
        before do
          subject.execute!
        end

        specify { subject.ability.send(:rules).should_not be_empty }
      end
    end
  end
end
