require 'spec_helper'

describe CanTango::Ability::Cache::RulesCache do
  let (:session) do
    {}
  end

  subject do
    CanTango::Ability::Cache::RulesCache.new session
  end

  specify { subject.should be_a CanTango::Ability::Cache::RulesCache }
end


