class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # DEVISE
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # OTHER
  attr_accessible :name, :role, :role_groups

  include_and_extend SimpleRoles

  tango_user # see macros

  has_friendly_id :name

  has_many :articles
  has_many :comments
  has_many :posts
  has_many :accounts, :foreign_key => "account_id"
end
