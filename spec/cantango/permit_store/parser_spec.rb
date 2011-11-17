require 'rspec'
require 'cantango'

describe CanTango::PermissionEngine::Parser do
  context 'simple targets without categories' do
    let (:parser) do
      CanTango::Permission::Parser.new
    end

    let :targets do
      ['all', 'Article', 'Comment']
    end

    it 'should parse targets' do
      pending
      #puts parser.parse(targets)
    end
  end

  context 'targets using categories' do
    let (:categories) do
      cats = {:articles => ['Comment', 'Post']}
      CanTango::Configuration::Categories.new :my_categories, cats
    end

    let (:parser) do
      CanTango::PermissionEngine::Parser.new categories
    end

    let :targets do
      ['all', '@articles']
    end

    it 'should parse targets' do
      pending
    end
  end
end

