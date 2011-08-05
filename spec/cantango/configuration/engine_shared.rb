shared_examples_for 'Engine' do
  describe 'turn off' do
    before :each do
      subject.send(:"#{state}", :off)
    end

    it 'should be turned off' do
      subject.send(:"#{state}?").should be_false
    end
  end

  describe 'turn on' do
    before :each do
      subject.send(:"#{state}", :on)
    end

    it 'should be turned on' do
      subject.send(:"#{state}?").should be_true
    end
  end
end



