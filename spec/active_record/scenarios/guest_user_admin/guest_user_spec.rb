require 'active_record/spec_helper'

require_all File.dirname(__FILE__) + "/../shared/" 

describe 'Scenario: users - :guest, :user, :admin' do
  context 'Guest user' do
    before(:each) do
      @guest ||= Guest.new
    end

    it_should_behave_like "Guest role" do
      let(:current_guest ) { @guest }
      let(:user) { current_user_ability(:guest) }
    end
  end
end
