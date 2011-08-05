require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::Engines::Permit do
    subject { CanTango::Configuration.engines.permit }

    describe 'SpecialPermits' do
      describe 'default settings' do
        its(:special_permits) { should include(:any, :system)
      end
    end
  end
end


