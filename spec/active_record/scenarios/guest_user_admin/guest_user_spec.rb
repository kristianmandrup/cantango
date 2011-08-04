require 'active_record/spec_helper'

require_all File.dirname(__FILE__) + "/../shared/" 

describe 'Scenario: users - :guest, :user, :admin' do
  context 'Guest user' do
    include Dancing::User

    before(:each) do
      @guest ||= Guest.new
    end

    it_should_behave_like "Guest role" do
      let(:current_guest ) { @guest }
      let(:user) { current_ability(:guest) }
    end

    it_should_behave_like "Dancing API: user" do
      let(:user) { User.create!(:role => "guest") }
      let(:current_guest) { user }
      let(:current_user) { user }
    end
  end
end 
