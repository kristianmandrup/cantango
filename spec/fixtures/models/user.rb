class User
  attr_accessor :name, :account, :email
  
  def initialize name, email = nil
    @name = name
    @email = email
  end 
  
  def email
    @email ||= 'default@gmail.com'
  end
end
