Stamper.scope :ability => "Ability#initialize" do |stan|
  stan.msg :no_cache          => 'No caching, going through engines'
  stan.msg :permissions_done  => "Permissions finished"
  stan.msg :permits_done      => "Permits finished"
  stan.msg :caching_done      => "Caching finished"
end

module CanTango
  class PerformanceTestAbility < CanTango::Ability
    def initialize candidate, options = {}

      raise "Candidate must be something!" if !candidate
      @candidate, @options = candidate, options
      @session = options[:session] || {} # seperate session cache for each type of user?

      if cached_rules?
        @rules_cached = true
        puts "Using Cache..."
        return
      end

      puts "\nAbility#initialize"

      stamper(:ability) {
        raise "Candidate must be something!" if !candidate
        @candidate, @options = candidate, options
        @session = options[:session] || {} # seperate session cache for each type of user?
      }

      begin
        @rules_cached = true
        puts "using cache..."
        return
      end if cached_rules?

      stamper(:ability)  {
        stamp(:no_cache)
        with(:permissions)  {|permission| permission.evaluate! user }
        stamp :permissions_done

        with(:permits)      {|permit| break if permit.execute == :break }
        stamp :permits_done

        with(:permissions)  {|permission| permission.evaluate! user }

        stamp :permissions_done

        with(:permits)      {|permit| break if permit.execute == :break }
        stamp :permits_done

        cache_rules!
        stamp :caching_done
      }
    end
  end
end

CanTango.config.ability.default_class = CanTango::PerformanceTestAbility
 

