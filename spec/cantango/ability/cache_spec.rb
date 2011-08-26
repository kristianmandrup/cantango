require 'rspec'
require 'cantango'
require 'fixtures/models'

puts "WARNING - TODO - Full caching spec !!!"

class CacheStub
  attr_accessor :user

  def initialize user
    @user = user
  end

  def rules
    @rules ||= [:rule_a, :rule_b]
  end

  protected

  def static_rules
    rules << :rule_c
  end

  def dynamic_rules
    rules << :rule_d
  end

  def cache
    @cache ||= CanTango::Ability::Cache.new
  end
end


def setup
  let (:user) do
    User.new 'kris'
  end

  let (:user2) do
    User.new 'stan'
  end

  let (:user_account) do
    ua = UserAccount.new user
    user.account = ua
  end
end


describe CanTango::Ability::Cache do
  setup

  let(:cache2) { CacheStub.new :stan }

  subject { CacheStub.new :kris }

  #its(:rules_cache) { should be_empty}
  its(:rules) { should_not be_empty }

=begin
  describe '#cache_key' do
    it { subject.cache_key.should be_a(String) }

    it 'should return the same key for same user' do
      subject.cache_key.should == subject.cache_key
    end

    it 'should return a unique key for each user' do
      subject.cache_key.should_not == cache2.cache_key
    end
  end

  describe '#cached_permit_rules?' do
    it 'should initially have no cached permit rules' do
      subject.cached_permit_rules?.should be_nil
    end
  end

  describe '#cache_rules!' do
    it 'should cache permit rules' do
      subject.cache_rules!.should_not be_nil
      subject.cached_permit_rules.should_not be_nil
      subject.cached_permit_rules?.should_not be_nil
      subject.cached_permit_rules.should include(:rule_a, :rule_b)
    end
  end

  describe '#cache_permit_rules!' do
    it 'should set static_rules and perform their caching' do
      subject.cache_permit_rules!.should_not be_nil
      subject.cached_permit_rules.should include(:rule_a, :rule_b, :rule_c)
    end
  end
  
  describe '#permit_rules!' do
    it 'should set dynamic rules without any caching' do
      subject.cached_permit_rules.should be_nil
      subject.permit_rules!
      subject.rules.should include(:rule_d)
      subject.cached_permit_rules.should be_nil
    end
  end

  describe '#get_permit_rules' do
    it 'should get all the rules - cached static rules + dynamic rules' do
      rules = subject.get_permit_rules
      rules.should include(:rule_a, :rule_b, :rule_c, :rule_d)
    end
  end
=end
end
