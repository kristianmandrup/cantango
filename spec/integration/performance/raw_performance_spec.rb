require 'dummy_spec_helper'
require'integration/performance/helpers/ability_raw'

describe "CanTango::Ability raw performance (without rails)" do
 
  it "total without engines" do
    @user = User.create!(:name => "Stanislaw")
    CanTangoTest.new(@user)
  end

end
