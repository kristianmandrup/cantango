shared_example 'Register' do
  describe 'default settings' do
    its(:registered)  { should include(subject.default) }

    it 'should register groups' do
      subject.register(:a, :b)
      subject.registered.should include(:a, :b)
    end

    it 'should set defaults' do
      subject.default = :a, :b
      subject.default.should include(:a, :b)
    end
  end
end
