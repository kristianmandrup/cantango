shared_examples_for 'Registry' do
  describe 'default settings' do
    
    #its(:registered)  { should be_empty }

    it 'should register groups' do
      subject.register(:a, :b)
      subject.registered.should include(:a, :b)
    end

    it 'should set defaults' do
      subject.default = :a, :b
      subject.default.should include(:a, :b)
    end
  end

  describe 'register' do
    before do
      subject.register :abc, :def
    end
    its(:registered) { should include(:abc, :def) }
  end

  describe 'append <<' do
    before do
      subject.clean!
      subject.register :abc, :def
      subject << :xyz
    end
    its(:registered) { should include(:abc, :def, :xyz) }
  end

  describe 'get index []' do
    before do
      subject.clean!
      subject.register :abc, :def
    end
    specify {subject[0].should == :abc }
  end
end
