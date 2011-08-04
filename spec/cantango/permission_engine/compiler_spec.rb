require 'rspec'
require 'cantango'
require 'hashie'
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
