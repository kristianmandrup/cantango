require 'spec_helper'

describe CanTango::Ability::Cache::Key do
  let (:session) do
    {}
  end

  let(:user) { User.new 'kris', 'kris@gmail.com' }
  let(:subj) { user }

  def set_valid_unique_field
    CanTango.config.user.unique_key_field = :email
  end

  def set_invalid_unique_field
    # unique_key_field not configured
    CanTango.config.user.unique_key_field = :blip
  end

  subject do
    CanTango::Ability::Cache::Key.new user, subj 
  end

  specify { subject.should be_a CanTango::Ability::Cache::Key }

  context 'using invalid user' do
    before do
      set_invalid_unique_field
    end

    specify { lambda { subject.value }.should raise_error }
  end

  context 'valid user' do
    before do
      set_valid_unique_field
    end

    specify { lambda { subject.value }.should_not raise_error }
    specify { subject.value.should be_a Fixnum } # hash
  end

  describe '#same?' do
    context 'set to same' do
 
      before do
        pending
        session[:cache_key] = subject.value
      end

      specify { subject.same?(session).should be_true }
    end

    context 'set to random' do
      before do
        pending
        session[:cache_key] = 25676923
      end

      specify { subject.same?(session).should be_false }
    end
  end
end

