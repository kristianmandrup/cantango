require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

describe CanTango::Api do
  subject { CanTango::Api }

  specify { subject.methods.should include(:current_user_ability) }
end
