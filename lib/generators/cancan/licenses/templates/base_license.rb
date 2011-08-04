class <%= license_name.to_s.camelize %>License < License::Base
  def initialize name
    super
  end

  def enforce!
  end
end
