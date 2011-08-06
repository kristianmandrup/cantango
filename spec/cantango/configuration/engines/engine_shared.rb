shared_examples_for 'Engine' do
  describe 'turn off' do
    before :each do
      subject.set :off
    end

    its(:on?)   { should be_false }
    its(:off?)  { should be_true  }
 end

  describe 'turn on' do
    before :each do
      subject.set :on
    end

    its(:on?)   { should be_true  }
    its(:off?)  { should be_false }
  end
end



