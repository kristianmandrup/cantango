require 'cantango'
require 'cantango/permit_engine/util'

module CanTango
  class Ability
    def initialize candidate, options = {}
      puts "\n\n! Using test variant of CanTango::Ability from spec/helpers !\n\n"
      raise "Candidate must be something!" if !candidate
      @candidate, @options = candidate, options
      @session = options[:session] || {} # seperate session cache for each type of user?

      @rules_cached = true and return if cached_rules?

      # run permission evaluators
      with(:permissions)  {|permission| permission.evaluate! user }
      with(:permits)      {|permit| break if permit.execute == :break }

      cache_rules!
    end
  
    def rules_cached?
      @rules_cached || false
    end
  end
  
end
