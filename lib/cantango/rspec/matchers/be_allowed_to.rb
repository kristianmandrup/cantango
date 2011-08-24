# http://solnic.eu/2011/01/14/custom-rspec-2-matchers.html


RSpec::Matchers.define :be_allowed_to do |action, objects|
  chain :with_options do |options|
    @options = options
  end

  match do |subject|
    @options ? subject.can?(action, objects, @options) : subject.can?(action, objects)
  end

  failure_message_for_should do |subject|
    %{expected that #{subject} could #{action} the #{objects}
#{subject.send :rules}}
  end

  failure_message_for_should_not do |actual|
    %{did not expect that #{subject} could #{action} the #{objects}
#{subject.send :rules}}
  end

  description do
    "be allowed to #{action} the #{objects}"
  end
end


