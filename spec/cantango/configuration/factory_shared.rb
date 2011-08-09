class CustomFactory
  attr_accessor :name, :options

  def initialize name, options = {}
    @name, @options = [name, options]
  end
end

shared_examples_for 'Factory' do
  describe 'configure factory' do
    describe 'set factory' do
      describe 'using non-callable' do
       it 'should not allow factory to be defined' do
          lambda { subject.factory {|name, opts| CustomFactory.new name, opts} }.should raise_error
        end
      end

      describe 'using lambda' do
        before :each do
          subject.factory lambda {|name, opts| CustomFactory.new name, opts}
        end

        it 'should set it' do
          subject.factory_build('hello', :works => true).name.should == 'hello'
        end
      end

      describe 'using Proc' do
        before :each do
          subject.factory Proc.new {|name, opts| CustomFactory.new name, opts}
        end

        it 'should set it' do
          subject.factory_build('hello', :works => true).name.should == 'hello'
        end
      end
    end
  end
end

