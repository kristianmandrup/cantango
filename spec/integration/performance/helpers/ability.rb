module CanTango
  class Ability
      def initialize candidate, options = {}
 
      stamper("Ability#initialize") {
      raise "Candidate must be something!" if !candidate
      @candidate, @options = candidate, options
      @session = options[:session] || {} # seperate session cache for each type of user?
      }
      
      begin
        @rules_cached = true 
        puts "using cache..."
        return 
      end if cached_rules?
     
      stamper("Ability#initialize: No caching, going through engines:") {
      with(:permissions)  {|permission| permission.evaluate! user }
      stamp "Permissions finished"
      with(:permits)      {|permit| break if permit.execute == :break }
      stamp "Permits finished"

      cache_rules!
      stamp "Caching finished"
      }
    end
  end  
end

