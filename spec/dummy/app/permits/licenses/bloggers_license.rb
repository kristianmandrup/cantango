class BloggersLicense < CanTango::PermitEngine::License
  def initialize name
    super
  end

  def static_rules
    can(:read, Article)
    can(:write, Post)
    can(:manage, Comment)
  end
end

