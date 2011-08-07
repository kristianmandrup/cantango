shared_examples_for 'Factory' do
  describe 'default settings' do
    its(:default_factory)  { should_not be_nil }

  end

  describe 'configure factory' do
    describe 'set default_factory' do
      before :each do
        subject.default_factory do
          '2'
        end
      end

      it 'should set it' do
        subject.default_factory.should == '2'
      end
    end
  end
end

