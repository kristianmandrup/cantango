require 'spec_helper'

describe CanTango::Ability::Cache::Reader do
  let (:session) do
    {}
  end

  let(:user) { User.new 'kris', 'kris@gmail.com' }

  let(:ability) { CanTango::Ability.new user, :session => session }

  let(:cache) { CanTango::Ability::Cache.new ability }

  subject do
    CanTango::Ability::Cache::Reader.new cache
  end

  specify { subject.should be_a CanTango::Ability::Cache::Reader }
end

