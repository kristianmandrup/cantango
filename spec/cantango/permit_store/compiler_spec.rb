require 'rspec'
require 'cantango'
require 'hashie'
require 'spec_helper'
def permission_fixture
  group = 'bloggers'
  rules = Hashie::Mash.new({"can"=>{"read"=>["Article", "Comment"]}, "cannot"=>{"write"=>["Article", "Post"]}})
  CanTango::PermissionEngine::Parser::Permissions.new.parse(group, rules) do |permission|
    return permission
  end
end

describe CanTango::PermissionEngine::Compiler do
  let (:permission) { permission_fixture }

  let(:compiler) do 
    compiler = CanTango::PermissionEngine::Compiler.new
    compiler.compile! permission
  end

  it 'should raise if permission contains not-valid actions' do
    expect {compiler.can_eval}.not_to raise_error
    # Replacing static_rules with rule that has not-valid action:
    permission.static_rules.can = Hashie::Mash.new({'edit' => ["Article"]})
    expect {compiler.can_eval}.to raise_error
  end

  it 'should produce cancan statements' do
    compiler.can_eval do |statements|
      statements.should == %|can(:read, Article)\ncan(:read, Comment)|
    end
  end

  it 'should produce cancan statements' do
    compiler.cannot_eval do |statements|
      statements.should == %|cannot(:write, Article)\ncannot(:write, Post)|
    end
  end

end
