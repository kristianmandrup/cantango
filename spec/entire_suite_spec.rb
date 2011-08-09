# Spec accumulating entire suite of working specs
require 'spec_helper'

dir = File.dirname(__FILE__) 

require_all "#{dir}/cantango/ability"

require_all "#{dir}/cantango/api"
require_all "#{dir}/cantango/permit_engine"

require "#{dir}/cantango/configuration_spec"
require_all "#{dir}/cantango/configuration"

require_all "#{dir}/cantango/permission_engine"
