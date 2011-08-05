# Spec accumulating entire suite of working specs
require 'spec_helper'

dir = File.dirname(__FILE__) 

require_all "#{dir}/cantango/permit_engine"

require_all "#{dir}/cantango/ability"

require_all "#{dir}/cantango/permission_engine/loader"

require "#{dir}/cantango/configuration_spec"
require "#{dir}/cantango/permission_engine/yaml_store_spec"
require "#{dir}/cantango/permission_engine/compiler_spec"
# will bootstrap soon:
#require_all "#{dir}/active_record"
