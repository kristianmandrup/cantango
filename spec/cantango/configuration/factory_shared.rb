shared_examples_for 'Factory' do
  describe 'configure factory' do
    describe 'set factory' do
      before :each do
        subject.factory do
          '2'
        end
      end

      it 'should set it' do
        subject.factory.should == '2'
      end
    end
  end
end

