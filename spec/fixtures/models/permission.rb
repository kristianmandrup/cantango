class Permission
  attr_accessor :thing, :thing_type, :action, :user

  def initialize user, action, thing
    @user, @action, @thing = [user, action, thing]
    @thing_type = @thing.class.to_s
  end

  def thing_id
    thing.id
  end
end
